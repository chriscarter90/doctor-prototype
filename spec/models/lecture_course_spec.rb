require 'spec_helper'

describe LectureCourse do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }

    # Other fields
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:term) }
  end

  describe "relationships" do
    it { should have_many(:requirements) }
    it { should have_many(:lecturers) }
    it { should have_many(:staff_members).through(:lecturers) }
    it { should have_many(:degree_classes).through(:requirements) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:lecture_course)
      obj.should be_valid
    end
  end
end
