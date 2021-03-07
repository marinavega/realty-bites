# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    category  { :sale }
    size      { Faker::Number.number(digits: 2) }
    rooms     { Faker::Number.number(digits: 1) }
    bathrooms { Faker::Number.number(digits: 1) }
    price     { Faker::Number.number(digits: 6) }
    link      { Faker::Internet.url }
    address   { Faker::Address.street_name }
    owner_id { 1 }
  end
end
