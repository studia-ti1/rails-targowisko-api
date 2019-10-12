# frozen_string_literal: true

describe 'POST /api/v1/users/login' do
  context 'when valid email but invalid password provided' do
    it 'returns proper error message'

    it 'returns proper HTTP status code'
  end

  context 'when valid email and password provided' do
    it 'returns user data with token'
  end
end
