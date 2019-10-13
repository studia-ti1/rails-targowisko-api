# frozen_string_literal: true

require 'rails_helper'

describe 'POST /api/v1/users' do
  subject { post '/api/v1/users', params: user_params }

  let(:user_params) do
    {
      'format' => 'json',
      'user' => {
        'email' => user_email,
        'password' => user_password
      }
    }
  end

  context 'when valid data provided' do
    let(:user_email) { 'not.existing.email@gmail.com' }
    let(:user_password) { Rails.application.secrets.develop_password }
    let(:jwt_decoded) { JWT.decode(JSON.parse(response.body)['user']['token'], Rails.application.secrets.jwt_secret) }

    context 'after user creation' do
      before { subject }

      it 'returns proper user data' do
        expect(json_response['user']).to include(
          'email' => user_email
        )
      end

      it 'returns token in response' do
        expect(jwt_decoded.first['id']).to eq User.first.id
      end

      # it 'returns proper HTTP status code' do
      #   # TODO: wrong
      #   # expect(response.status).to eq 201
      # end
    end

    context 'during user creation' do
      it 'creates a User record' do
        expect { subject }.to change(User, :count).by(+1)
      end
    end
  end

  context 'when invalid data provided' do
    before { subject }

    let!(:existing_user) { create :user }
    let(:user_email) { existing_user.email }
    let(:user_password) { Rails.application.secrets.develop_password }
    let(:error_response) do
      {
        'errors' => {
          'email' => [
            'has already been taken'
          ]
        }
      }
    end

    it 'returns proper validation error' do
      expect(json_response).to eq error_response
    end

    it 'returns proper HTTP status code' do
      expect(response.status).to eq 422
    end
  end
end
