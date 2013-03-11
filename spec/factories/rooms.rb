# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :room do
    sequence(:no)     { |n| 300 + n }
    capacity          { 1 + rand(200) }
    year
  end
end
