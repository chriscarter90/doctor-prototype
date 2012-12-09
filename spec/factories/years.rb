# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :year do
    sequence(:no)    { |n| 2000 + n }
  end
end
