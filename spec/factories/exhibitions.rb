# frozen_string_literal: true

FactoryBot.define do
  factory :exhibition do
    name { FFaker::Company.name }
  end
end
