# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :year do
    sequence(:no)    { |n| 2000 + n }

    after(:build) do |year|
      year.terms.push(FactoryGirl.create(:term, :year => year))
    end
  end
end
