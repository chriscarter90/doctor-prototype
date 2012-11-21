# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecturer do
    staff_member
    lecture_course
    role            { ["Lecturer", "Organised"].sample }
    staffhours      { 1 + rand(20) }
    term            "1, 2"
  end
end
