# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timetable_slot do
    room
    time_slot
    lecture_course
    week
  end
end
