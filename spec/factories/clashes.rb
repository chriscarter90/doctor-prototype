# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clash do |c|
    association :a_course, :factory => :lecture_course
    association :b_course, :factory => :lecture_course
    year
  end
end
