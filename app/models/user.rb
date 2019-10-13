# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  # required by the json builder
  def generate_jwt
    JwtHelper.encode(user_id: id)
  end
end
