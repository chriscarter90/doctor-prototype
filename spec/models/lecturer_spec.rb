require 'spec_helper'

describe Lecturer do
  describe "validations" do
    it { should validate_presence_of(:staff_member) }
    it { should validate_presence_of(:lecture_course) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:staffhours) }
    it { should validate_presence_of(:term) }
  end

  describe "relationships" do
    it { should belong_to(:staff_member) }
    it { should belong_to(:lecture_course) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:lecturer)
      obj.should be_valid
    end
  end
end
