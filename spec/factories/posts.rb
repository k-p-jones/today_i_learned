# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.words(number: 6) }
    user
  end
end
