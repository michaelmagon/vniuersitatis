FactoryBot.define do
  factory :user do
    name {"Student User"}
    sequence(:email) { |n| "test-#{n}@example.com" }
    user_type {"student"}
    password {"123123"}
  end
end