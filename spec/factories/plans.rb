# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    user
    title { Faker::Lorem.sentence(word_count: 3) }
  end
end
