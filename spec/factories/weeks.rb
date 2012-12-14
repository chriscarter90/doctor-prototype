# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :week do
    term
    no      { 1 + rand(11) }
    date    { Date.parse("01/01/2013") }
  end
end
