FactoryBot.define do
  factory :course_student do
    student {create(:user, user_type: 'student')}
    course {create(:course)}
    status {'pending'}
  end
end