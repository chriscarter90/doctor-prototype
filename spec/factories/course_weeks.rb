# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_week do
    week
    lecture_course
    staff_member
  end
end
