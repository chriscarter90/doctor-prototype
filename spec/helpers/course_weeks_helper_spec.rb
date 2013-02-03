require "spec_helper"

describe CourseWeeksHelper do
  describe "find_existing_hours" do
    it "should return the correct number of hours if such a record exists, else 0" do
      @year = FactoryGirl.build(:year)
      @year.terms = [
                      FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :year => @year),
                      FactoryGirl.create(:term, :no => 3, :no_weeks => 6, :year => @year),
                      FactoryGirl.create(:term, :no => 2, :no_weeks => 5, :year => @year)
                    ]
      @year.save!

      @c1 = FactoryGirl.create(:lecture_course, :code => "123B", :term => "1")
      @c2 = FactoryGirl.create(:lecture_course, :code => "101", :term => "2")

      @staff1 = FactoryGirl.create(:staff_member, :login => "abc123", :salutation => "Dr", :firstname => "Testy", :lastname => "McTest")
      @staff2 = FactoryGirl.create(:staff_member, :login => "zyx987", :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein")
      @staff3 = FactoryGirl.create(:staff_member, :login => "jkl456", :salutation => "Prof", :firstname => "Doc", :lastname => "Tor")

      FactoryGirl.create(:lecturer, :staff_member => @staff1, :lecture_course => @c1, :role => "Lecturer")
      FactoryGirl.create(:lecturer, :staff_member => @staff2, :lecture_course => @c1, :role => "Lecturer")
      FactoryGirl.create(:lecturer, :staff_member => @staff3, :lecture_course => @c1, :role => "Organiser")
      FactoryGirl.create(:lecturer, :staff_member => @staff2, :lecture_course => @c2, :role => "Lecturer")

      @week = @year.terms.first.weeks.first

      FactoryGirl.create(:course_week, :staff_member => @staff1, :lecture_course => @c1, :week => @week, :hours => 3, :session_type => "Lecture")

      helper.find_existing_hours(@c1, @week, @staff1, "Lecture").should == 3
      helper.find_existing_hours(@c1, @year.terms.first.weeks.last, @staff1, "Lecture").should == 0
      helper.find_existing_hours(@c1, @week, @staff2, "Lecture").should == 0
      helper.find_existing_hours(@c1, @week, @staff1, "Tutorial").should == 0
    end
  end
end
