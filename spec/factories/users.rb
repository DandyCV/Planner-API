# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { ContextHelper.random_email }
    password { ContextHelper.random_password }
  end
end
