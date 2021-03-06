# frozen_string_literal: true

FactoryBot.define do
  factory :owner do
    category  { :independent }
    name      { Faker::Name.name }
    phone     { Faker::PhoneNumber.phone_number }
    email     { Faker::Internet.email }
  end
end
