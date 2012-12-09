require 'spec_helper'

describe Day do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:no) }
    it { should validate_uniqueness_of(:no) }

    # Other fields
    it { should validate_presence_of(:name) }
  end

  describe "relationships" do
    it { should have_many(:time_slots) }
  end

  describe "scopes" do
    describe "in_order" do
      it "should return the days in order" do
        d1 = FactoryGirl.create(:day, :name => "Thursday", :no => 4)
        d2 = FactoryGirl.create(:day, :name => "Monday", :no => 1)
        d3 = FactoryGirl.create(:day, :name => "Saturday", :no => 6)

        Day.in_order.should == [d2, d1, d3]
        Day.in_order.map(&:name).should == ["Monday", "Thursday", "Saturday"]
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.create(:day)
      obj.should be_valid
    end
  end
end
