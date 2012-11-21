# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture_course do
    sequence(:code)       { |n| "T#{n}" }
    title                 Faker::Company.catch_phrase
    term                  "1, 2"
  end
end
