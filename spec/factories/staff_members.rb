# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :staff_member do
    sequence(:login)  { |n| "staff#{n}" }
    salutation        Faker::Name.prefix
    firstname         Faker::Name.first_name
    lastname          Faker::Name.last_name
    year
  end
end
