class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # UNIVERSITY: required by the json builder
  def generate_jwt
    JwtHelper.encode(user_id: id)
  end
end
