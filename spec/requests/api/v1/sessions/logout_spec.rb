# frozen_string_literal: true

describe 'DELETE /api/v1/users/login' do
  context 'when invalid token provided' do
    it 'returns header with proper HTTP status'
  end

  context 'when valid token provided' do
    it 'created JwtBlacklist record'

    it 'creates JwtBlacklist record with valid jti'
  end
end
