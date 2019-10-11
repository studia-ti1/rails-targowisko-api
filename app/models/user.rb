class User < ApplicationRecord
  # UNIVERSITY model uzytkownika - ponizej linijka konfiguracyjna biblioteke devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
