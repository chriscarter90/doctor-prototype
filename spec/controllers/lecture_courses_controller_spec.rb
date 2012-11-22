require 'spec_helper'

describe LectureCoursesController do
  describe "GET / index" do
    before :each do
      @c1 = FactoryGirl.create(:lecture_course)
      @c2 = FactoryGirl.create(:lecture_course)
      @c3 = FactoryGirl.create(:lecture_course)
    end

    it "should assign @courses with all the courses" do
      get :index

      assigns(:courses).size.should == 3
      assigns(:courses).should include(@c1, @c2, @c3)
    end
  end

  describe "GET / show" do
    before :each do
      @c = FactoryGirl.create(:lecture_course)

      @r1 = FactoryGirl.create(:requirement, :lecture_course => @c)
      @r2 = FactoryGirl.create(:requirement, :lecture_course => @c)
    end

    it "should assign @course with the correct course" do
      get :show, :id => @c

      assigns(:course).should == @c
    end

    it "should assign @requirements with the requirements for the course" do
      get :show, :id => @c

      assigns(:requirements).size.should == 2
      assigns(:requirements).should include(@r1, @r2)
    end
  end
end
