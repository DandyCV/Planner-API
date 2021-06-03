# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Name.name }
    password { Faker::Internet.email }
  end
end
