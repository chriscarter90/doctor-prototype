require 'spec_helper'

describe Term do
  describe "validations" do
    it { should validate_presence_of(:no) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:start_date) }

    it "should have at least one week" do
      t = FactoryGirl.build(:term, :no_weeks => 0)
      t.should_not be_valid

      t = FactoryGirl.build(:term, :no_weeks => 3)
      t.should be_valid
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

  describe "before_save" do
    it "should create the number of weeks required" do
      t = FactoryGirl.build(:term, :no_weeks => 4)
      t.save!
      t.weeks.size.should == 4
    end
  end
end
