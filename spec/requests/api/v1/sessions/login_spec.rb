# frozen_string_literal: true

require 'rails_helper'

describe 'POST /api/v1/users/login' do
  subject { post '/api/v1/users/login', params: user_params }

  let!(:user) { create :user, password: Rails.application.secrets.develop_password }

  let(:user_params) do
    {
      "user": {
        "email": user_email,
        "password": user_password
      }
    }
  end

  before { subject }

  context 'when invalid data provided' do
    let(:error_response) do
      {
        'errors' => {
          'email or password' => ['is invalid']
        }
      }
    end

    context 'invalid email' do
      let(:user_email) { 'invalid.email@gmail.com' }
      let(:user_password) { user.email }

      it 'returns proper error message' do
        expect(json_response).to eq(error_response)
      end

      it 'returns proper HTTP status code' do
        expect(response.status).to eq 422
      end
    end

    context 'invalid password' do
      let(:user_password) { 'secret_invalid_password' }
      let(:user_email) { user.email }
      # TODO: extract this to shared examples

      it 'returns proper error message' do
        expect(json_response).to eq(error_response)
      end

      it 'returns proper HTTP status code' do
        expect(response.status).to eq 422
      end
    end
  end

  context 'when valid email and password provided' do
    let(:user_password) { user.password }
    let(:user_email) { user.email }
    let(:jwt_decoded) { JWT.decode(JSON.parse(response.body)['user']['token'], Rails.application.secrets.jwt_secret) }

    it 'returns user data' do
      expect(json_response['user']).to include(
        'id' => user.id,
        'email' => user.email
      )
    end

    it 'returns token in response' do
      expect(jwt_decoded.first['id']).to eq user.id
    end
  end
end
