# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@gmail.com" }
    password { Rails.application.secrets.develop_password }
  end
end
