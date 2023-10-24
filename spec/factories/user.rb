FactoryBot.define do
  factory :user do
    name {"Student User"}
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    user_type {"student"}
    password {"123123"}
  end
end