require 'spec_helper'

describe StaffMember do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:login) }
    it { should validate_uniqueness_of(:login) }

    # Other fields
    it { should validate_presence_of(:salutation) }
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
  end

  describe "relationships" do
    it { should have_many(:lecturers) }
    it { should have_many(:lecture_courses).through(:lecturers) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:staff_member)
      obj.should be_valid
    end
  end
end
