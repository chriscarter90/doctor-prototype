require 'spec_helper'

describe LectureCourse do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:code) }

    # Other fields
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:term) }
    it { should validate_presence_of(:year) }

    it "should validate uniqueness in each year" do
      @year = FactoryGirl.create(:year)

      FactoryGirl.create(:lecture_course, :year => @year, :code => "123")

      lambda { FactoryGirl.create(:lecture_course, :year => @year, :code => "123") }.should raise_error(ActiveRecord::RecordNotUnique)

      lambda { FactoryGirl.create(:lecture_course, :code => "123") }.should_not raise_error(ActiveRecord::RecordNotUnique)
    end
  end

  describe "relationships" do
    it { should have_many(:requirements) }
    it { should have_many(:lecturers) }
    it { should have_many(:staff_members).through(:lecturers) }
    it { should have_many(:degree_classes).through(:requirements) }
    it { should have_many(:course_weeks) }
    it { should have_many(:timetable_slots) }
    it { should have_and_belong_to_many(:clashes) }
    it { should belong_to(:year) }
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

    describe "has_lecturers" do
      it "should return the courses who have lecturers" do
        c1 = FactoryGirl.create(:lecture_course, :code => "789")
        c2 = FactoryGirl.create(:lecture_course, :code => "M640")
        c3 = FactoryGirl.create(:lecture_course, :code => "123")

        FactoryGirl.create(:lecturer, :lecture_course => c1, :role => "Lecturer")
        FactoryGirl.create(:lecturer, :lecture_course => c1, :role => "Lecturer")
        FactoryGirl.create(:lecturer, :lecture_course => c2, :role => "Organiser")

        LectureCourse.has_lecturers.should == [c1]
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

  describe "total_hours" do
    it "should return the total number of teaching hours, including lectures, tutorials and labs" do
      c1 = FactoryGirl.create(:lecture_course, :lecturehours => 28, :tutorialhours => 20, :labhours => 4)
      c1.total_hours.should == 52

      c2 = FactoryGirl.create(:lecture_course, :lecturehours => 40, :tutorialhours => nil, :labhours => nil)
      c2.total_hours.should == 40
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
    it "should return whether the course is taught in the given term" do
      c1 = FactoryGirl.create(:lecture_course, :term => "1, 2")

      term = FactoryGirl.create(:term, :no => 2)
      c1.taught_in_term?(term).should be_true

      c2 = FactoryGirl.create(:lecture_course, :term => "1")

      c2.taught_in_term?(term).should be_false
    end
  end

  describe "has_multiple_lecturers?" do
    it "should return whether the course has many lecturers" do
      c1 = FactoryGirl.create(:lecture_course)

      FactoryGirl.create(:lecturer, :lecture_course => c1, :role => "Lecturer")

      c1.has_multiple_lecturers?.should be_false

      FactoryGirl.create(:lecturer, :lecture_course => c1, :role => "Lecturer")

      c1.has_multiple_lecturers?.should be_true
    end
  end

  describe "display_name" do
    it "should return the course code and the title" do
      c1 = FactoryGirl.create(:lecture_course, :code => "112", :title => "Hardware")
      c2 = FactoryGirl.create(:lecture_course, :code => "234", :title => "Example Course")

      c1.display_name.should == "112 - Hardware"
      c2.display_name.should == "234 - Example Course"
    end
  end
end
