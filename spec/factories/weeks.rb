# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :week do
    term
    no      { 1 + rand(11) }
  end
end
