# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clash do |c|
    year
    lecture_courses {[FactoryGirl.create(:lecture_course)]}
  end
end
