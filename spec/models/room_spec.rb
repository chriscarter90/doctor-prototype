require 'spec_helper'

describe Room do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:no) }

    # Other fields
    it { should validate_presence_of(:capacity) }
    it { should validate_presence_of(:year) }

    it "should validate uniqueness in each year" do
      @year = FactoryGirl.create(:year)

      FactoryGirl.create(:room, :year => @year, :no => "311")

      lambda { FactoryGirl.create(:room, :year => @year, :no => "311") }.should raise_error(ActiveRecord::RecordNotUnique)

      lambda { FactoryGirl.create(:room, :code => "311") }.should_not raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "relationships" do
    it { should have_many(:timetable_slots) }
    it { should belong_to(:year) }
  end

  describe "scopes" do
    describe "by_no" do
      it "should return the rooms in no order" do
        year = FactoryGirl.create(:year, :no => 2011)

        r1 = FactoryGirl.create(:room, :no => 308, :year => year)
        r2 = FactoryGirl.create(:room, :no => 201, :year => year)
        r3 = FactoryGirl.create(:room, :no => 301, :year => year)

        year.rooms.by_no.should == [r2, r3, r1]
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:room)
      obj.should be_valid
    end
  end

  describe "to_param" do
    it "should return the room no and not its id" do
      year = FactoryGirl.create(:year, :no => 2011)

      obj = FactoryGirl.build(:room, :id => 1, :no => 308, :year => year)
      obj.to_param.should == 308
      obj.to_param.should_not == 1
    end
  end
end
