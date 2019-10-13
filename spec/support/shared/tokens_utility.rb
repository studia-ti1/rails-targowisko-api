# frozen_string_literal: true

shared_context 'tokens_utility' do
  let(:valid_token) { 'Bearer valid.token.token' }
  let(:invalid_token) { 'Bearer invalid.token.token' }
  let(:jwt_secret) { Rails.application.secrets.jwt_secret }
  let(:jwt_payload) { [{ 'id' => user.id, 'jti' => 'sample_jti' }] }
  let(:allow_jwt_parser) do
    allow(JWT).to receive(:decode).with(valid_token.split(' ').second, jwt_secret).and_return(jwt_payload)
    allow(JWT).to receive(:decode).with(invalid_token.split(' ').second, jwt_secret).and_raise(JWT::VerificationError)
  end
end
