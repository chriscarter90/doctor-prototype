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
    it { should have_many(:course_weeks) }
  end

  describe "scopes" do
    describe "by_code" do
      it "should return the courses in code order" do
        c1 = FactoryGirl.create(:lecture_course, :code => "789")
        c2 = FactoryGirl.create(:lecture_course, :code => "M640")
        c3 = FactoryGirl.create(:lecture_course, :code => "123")

        LectureCourse.by_code.should == [c3, c1, c2]
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:lecture_course)
      obj.should be_valid
    end
  end

  describe "to_param" do
    it "should return the course code and not its id" do
      obj = FactoryGirl.build(:lecture_course, :id => 123, :code => "234")
      obj.to_param.should == "234"
      obj.to_param.should_not == 123
    end
  end
end
