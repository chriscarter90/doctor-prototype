require 'spec_helper'

describe CourseWeek do
  describe "validations" do
    it { should validate_presence_of(:week) }
    it { should validate_presence_of(:staff_member) }
    it { should validate_presence_of(:lecture_course) }
  end

  describe "relationships" do
    it { should belong_to(:week) }
    it { should belong_to(:staff_member) }
    it { should belong_to(:lecture_course) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.create(:course_week)
      obj.should be_valid
    end
  end
end
