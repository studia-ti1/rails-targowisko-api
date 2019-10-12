require 'jwt'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def generate_jwt
    jti_raw = [SecureRandom.uuid.to_s, Time.current.to_i.to_s].join(':').to_s
    jti = Digest::MD5.hexdigest(jti_raw)
    JWT.encode({ id: id,
                 exp: 60.days.from_now.to_i,
                jti: jti},
               'secret')
  end
end
