require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '666666' }
  end
end
