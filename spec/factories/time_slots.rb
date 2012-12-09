# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :time_slot do
    day
    start_hour { 9 + rand(8) }
  end
end
