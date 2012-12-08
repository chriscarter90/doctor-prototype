# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :day do
    sequence(:no)     { |n| n }
    name              "Woo-day"
  end
end
