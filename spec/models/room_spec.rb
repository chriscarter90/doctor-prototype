require 'spec_helper'

describe Room do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:no) }
    it { should validate_uniqueness_of(:no) }

    # Other fields
    it { should validate_presence_of(:capacity) }
  end

  describe "scopes" do
    describe "by_no" do
      it "should return the rooms in no order" do
        r1 = FactoryGirl.create(:room, :no => 308)
        r2 = FactoryGirl.create(:room, :no => 201)
        r3 = FactoryGirl.create(:room, :no => 301)

        Room.by_no.should == [r2, r3, r1]
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:room)
      obj.should be_valid
    end
  end
end
