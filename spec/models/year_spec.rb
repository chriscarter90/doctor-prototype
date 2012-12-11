require 'spec_helper'

describe Year do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:no) }
    it { should validate_uniqueness_of(:no) }
  end

  describe "relationships" do
    it { should have_many(:terms) }
  end

  describe "scopes" do
    describe "in_order" do
      it "should return years in chronological order" do
        y1 = FactoryGirl.create(:year, :no => 2011)
        y2 = FactoryGirl.create(:year, :no => 2012)
        y3 = FactoryGirl.create(:year, :no => 2010)

        Year.in_order.should == [y3, y1, y2]
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:year)
      obj.should be_valid
    end
  end
end
