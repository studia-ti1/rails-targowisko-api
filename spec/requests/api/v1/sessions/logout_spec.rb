# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE /api/v1/users/logout' do
  subject { delete '/api/v1/users/logout', headers: { 'Authorization' => token } }

  let!(:user) { create :user }
  let(:valid_token) { 'Bearer valid.token.token' }
  let(:invalid_token) { 'Bearer invalid.token.token' }
  let(:jwt_secret) { Rails.application.secrets.jwt_secret }
  let(:jwt_payload) { [{ 'id' => user.id, 'jti' => 'sample_jti' }] }
  let(:allow_jwt_parser) do
    allow(JWT).to receive(:decode).with(valid_token.split(' ').second, jwt_secret).and_return(jwt_payload)
    allow(JWT).to receive(:decode).with(invalid_token.split(' ').second, jwt_secret).and_raise(JWT::VerificationError)
  end

  context 'when invalid token provided' do
    let(:token) { invalid_token }

    before do
      allow_jwt_parser
      subject
    end

    it 'returns proper error' do
      expect(json_response['errors']).to match_array ['Not Authenticated']
    end

    it 'returns proper HTTP status code' do
      expect(response.status).to eq 401
    end
  end

  context 'when valid token provided' do
    let(:token) { valid_token }

    before { allow_jwt_parser }

    it 'created JwtBlacklist record' do
      expect { subject }.to change(JwtBlacklist, :count).by(+1)
    end

    it 'creates JwtBlacklist record with valid jti' do
      subject
      expect(JwtBlacklist.last.jti).to eq jwt_payload.first['jti']
    end
  end
end
