# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :requirement do
    degree_class
    lecture_course
    required          { ["Required", "Selected", "Optional"].sample }
  end
end
