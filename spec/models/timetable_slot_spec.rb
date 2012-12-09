require 'spec_helper'

describe TimetableSlot do
  describe "validations" do
    it { should validate_presence_of(:lecture_course) }
    it { should validate_presence_of(:room) }
    it { should validate_presence_of(:time_slot) }
    it { should validate_presence_of(:week) }
  end

  describe "relationships" do
    it { should belong_to(:lecture_course) }
    it { should belong_to(:room) }
    it { should belong_to(:time_slot) }
    it { should belong_to(:week) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.create(:timetable_slot)
      obj.should be_valid
    end
  end
end
