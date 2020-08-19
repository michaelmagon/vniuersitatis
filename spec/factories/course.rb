FactoryBot.define do
  factory :course do
    title {Faker::App.name}
    content {Faker::Lorem.paragraph(sentence_count: 3)}
    summary {Faker::Lorem.paragraph(sentence_count: 1)}
    cover_source {Faker::Company.logo}
    teacher {FactoryBot.create(:user, user_type: 'teacher')}
    status {1}
    student_limit {20}
    start_date {Faker::Date.in_date_period(month: 2)}
    end_date {Faker::Date.in_date_period(month: 2)}
    slug {Faker::Alphanumeric.alphanumeric(number: 10)}
  end
end