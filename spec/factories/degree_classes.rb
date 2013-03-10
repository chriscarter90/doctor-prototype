# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :degree_class do
    sequence(:degreeyr)       { |n| "deg#{n}" }
    sequence(:letteryr)       { |n| "d#{n}"   }
    title                     Faker::Company.catch_phrase
    year
  end
end
