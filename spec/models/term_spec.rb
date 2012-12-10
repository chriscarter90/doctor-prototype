require 'spec_helper'

describe Term do
  describe "validations" do
    it { should validate_presence_of(:no) }
    it { should validate_presence_of(:year) }

    it "should ensure that it has at least one week" do
      term = FactoryGirl.build(:term)
      term.weeks = []
      term.should_not be_valid

      term = FactoryGirl.build(:term)
      term.weeks.push(FactoryGirl.build(:week, :term => term))
      term.should be_valid
    end
  end

  describe "relationships" do
    it { should belong_to(:year) }
    it { should have_many(:weeks) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:term)
      obj.should be_valid
    end
  end
end
