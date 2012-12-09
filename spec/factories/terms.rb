# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :term do
    year
    no        { 1 + rand(3) }
  end
end
