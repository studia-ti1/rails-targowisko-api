# frozen_string_literal: true

require 'jwt'

class JwtHelper
  # UNIVERSITY decode incomming token
  def self.decode(token:)
    JWT.decode(token, Rails.application.secrets.jwt_secret).first
  end

  # UNIVERSITY encodes JWT and generated JTI for blacklisting
  def self.encode(user_id:)
    jti_raw = [SecureRandom.uuid.to_s, Time.current.to_i.to_s].join(':').to_s
    jti = Digest::MD5.hexdigest(jti_raw)
    JWT.encode({ id: user_id,
                 exp: 24.hours.from_now.to_i,
                 jti: jti },
               Rails.application.secrets.jwt_secret)
  end
end
