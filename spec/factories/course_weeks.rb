# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course_week do
    week
    lecture_course
    staff_member
    hours         { 1 + rand(3) }
    session_type  "Lecture"
  end
end
