require 'spec_helper'

describe ClashesController do
  describe "GET / index" do
    before :each do
      @y = FactoryGirl.create(:year, :no => 2011)

      @course1 = FactoryGirl.create(:lecture_course, :code => "234")
      @course2 = FactoryGirl.create(:lecture_course, :code => "345")
      @course3 = FactoryGirl.create(:lecture_course, :code => "123")

      @c1 = FactoryGirl.create(:clash, :year => @y, :lecture_courses => [@course1, @course2])
      @c2 = FactoryGirl.create(:clash, :lecture_courses => [])
      @c3 = FactoryGirl.create(:clash, :year => @y, :lecture_courses => [@course3])

      FactoryGirl.create(:lecturer, :lecture_course => @course1, :role => "Lecturer")
      FactoryGirl.create(:lecturer, :lecture_course => @course3, :role => "Lecturer")
    end

    it "should assign @year with the correct year" do
      get :index, :year_id => @y

      assigns(:year).should == @y
    end

    it "should assign @clashes with the clashes" do
      get :index, :year_id => @y

      assigns(:clashes).should include(@c1, @c3)
      assigns(:clashes).should_not include(@c2)
    end

    it "should assign @courses with all of the courses in course code order, only those with lecturers" do
      get :index, :year_id => @y

      assigns(:courses).should include(@course1, @course3)
      assigns(:courses).should_not include(@course2)
      assigns(:courses).should == [@course3, @course1]
    end
  end
end
