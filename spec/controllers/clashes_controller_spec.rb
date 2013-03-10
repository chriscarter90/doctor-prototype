require 'spec_helper'

describe ClashesController do
  describe "GET / index" do
    before :each do
      @y = FactoryGirl.create(:year, :no => 2012)

      @course1 = FactoryGirl.create(:lecture_course, :code => "234", :year => @y)
      @course2 = FactoryGirl.create(:lecture_course, :code => "345", :year => @y)
      @course3 = FactoryGirl.create(:lecture_course, :code => "123", :year => @y)

      @c1 = FactoryGirl.create(:clash, :year => @y, :lecture_courses => [@course1, @course2])
      @c2 = FactoryGirl.create(:clash, :lecture_courses => [])
      @c3 = FactoryGirl.create(:clash, :year => @y, :lecture_courses => [@course3])

      FactoryGirl.create(:lecturer, :lecture_course => @course1, :staff_member => FactoryGirl.create(:staff_member, :year => @y), :role => "Lecturer")
      FactoryGirl.create(:lecturer, :lecture_course => @course2, :staff_member => FactoryGirl.create(:staff_member, :year => @y), :role => "Lecturer")
      FactoryGirl.create(:lecturer, :lecture_course => @course3, :staff_member => FactoryGirl.create(:staff_member, :year => @y), :role => "Lecturer")
      FactoryGirl.create(:lecturer, :lecture_course => @course1, :staff_member => FactoryGirl.create(:staff_member, :year => @y), :role => "Lecturer")

      ###
      # Unnecessary for the tests below
      ###
      @degree1 = FactoryGirl.create(:degree_class, :letteryr => "c3", :year => @y)
      @degree2 = FactoryGirl.create(:degree_class, :letteryr => "c2", :year => @y)
      @degree3 = FactoryGirl.create(:degree_class, :letteryr => "c4", :year => @y)

      FactoryGirl.create(:requirement, :degree_class => @degree1, :lecture_course => @course1)
      FactoryGirl.create(:requirement, :degree_class => @degree2, :lecture_course => @course2)
      FactoryGirl.create(:requirement, :degree_class => @degree3, :lecture_course => @course3)
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
