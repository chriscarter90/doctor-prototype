# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lecture_course do
    sequence(:code)       { |n| "T#{n}" }
    title                 Faker::Company.catch_phrase
    term                  "1, 2"
    lecturehours          { 3 * (1 + rand(5)) }
    tutorialhours         { 3 * (1 + rand(2)) }
    labhours              { 3 * (1 + rand(1)) }
    weeklyhours           "3"
  end
end
