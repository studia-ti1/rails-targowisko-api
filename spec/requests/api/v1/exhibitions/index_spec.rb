# frozen_string_literal: true

require 'rails_helper'

describe 'GET /api/v1/exhibitions' do
  subject { get '/api/v1/exhibitions', headers: { 'Authorization' => token } }

  let!(:exhibitions) { create_list :exhibition, 3 }
  let!(:user) { create :user }

  include_context 'tokens_utility'

  context 'when user authenticated' do
    before do
      allow_jwt_parser
      subject
    end

    let(:token) { valid_token }
    let(:proper_exhibitions_data) do
      response_array = []
      exhibitions.each do |exh|
        response_array << { 'id' => exh.id, 'name' => exh.name }
      end

      response_array
    end

    it 'returns proper exhibitions data' do
      expect(json_response).to match_array(proper_exhibitions_data)
    end

    it 'returns proper HTTP status' do
      expect(response.status).to eq 200
    end
  end

  context 'when user not authenticated or invalid token provided' do
    context 'when token blacklisted' do
      let(:token) { valid_token }

      before do
        allow_jwt_parser
        create :jwt_blacklist, jti: jwt_payload.first['jti']
        subject
      end

      it 'returns proper error message' do
        expect(json_response['errors']).to match_array ['Not Authenticated']
      end

      it 'returns proper HTTP status code' do
        expect(response.status).to eq 401
      end
    end

    context 'when not valid token' do
      before do
        allow_jwt_parser
        subject
      end

      let(:token) { invalid_token }

      it 'returns proper HTTP status code' do
        expect(response.status).to eq 401
      end

      it 'returns proper error message' do
        expect(json_response['errors']).to match_array ['Not Authenticated']
      end
    end
  end
end
