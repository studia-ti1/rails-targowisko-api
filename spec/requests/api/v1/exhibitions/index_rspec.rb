# frozen_string_literal: true

describe 'GET /api/v1/exhibitions/index' do
  context 'when user authenticated' do
    it 'returns proper exhibitions data'

    it 'returns proper HTTP status'
  end

  context 'when user not authenticated or invalid token provided' do
    # blacklisted toekn, not valid token or no token at all
    it 'returns :unauthorized status code'
  end
end
