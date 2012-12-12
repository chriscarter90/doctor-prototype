# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :term do
    year
    sequence(:no)       { |n| n }
    no_weeks            1
    start_date          Date.parse("01/01/2013")
  end
end
