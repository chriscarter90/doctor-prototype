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
    it { should have_many(:timetable_slots) }
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

  describe "terms_taught" do
    it "should return the terms in which the course is taught" do
      c1 = FactoryGirl.create(:lecture_course, :term => "1, 2")

      c1.terms_taught.should include(1, 2)
      c1.terms_taught.should_not include(3)

      c2 = FactoryGirl.create(:lecture_course, :term => "2")

      c2.terms_taught.should include(2)
      c2.terms_taught.should_not include(1, 3)
    end
  end

  describe "taught_in_term?" do
    it "should whether the course is taught in the given term" do
      c1 = FactoryGirl.create(:lecture_course, :term => "1, 2")

      term = FactoryGirl.create(:term, :no => 2)
      c1.taught_in_term?(term).should be_true

      c2 = FactoryGirl.create(:lecture_course, :term => "1")

      c2.taught_in_term?(term).should be_false
    end
  end
end
