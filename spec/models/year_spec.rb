require 'spec_helper'

describe Year do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:no) }
    it { should validate_uniqueness_of(:no) }

    it "should ensure that it has at least one term" do
      year = FactoryGirl.build(:year)
      year.terms = []
      year.should_not be_valid

      year = FactoryGirl.build(:year)
      year.terms.push(FactoryGirl.build(:term))
      year.should be_valid
    end
  end

  describe "relationships" do
    it { should have_many(:terms) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:year)
      obj.should be_valid
    end
  end
end
