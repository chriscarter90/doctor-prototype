# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :term do
    year
    sequence(:no)        { |n| n }
  end
end
