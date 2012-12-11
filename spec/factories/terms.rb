# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :term do
    year
    sequence(:no)        { |n| n }

    after(:build) do |term|
      if term.weeks.empty?
        term.weeks << FactoryGirl.create(:week, :term => term)
      end
    end
  end
end
