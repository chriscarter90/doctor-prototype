require 'spec_helper'

describe LectureCoursesController do
  describe "GET / index" do
    before :each do
      @c1 = FactoryGirl.create(:lecture_course, :code => "789")
      @c2 = FactoryGirl.create(:lecture_course, :code => "M640")
      @c3 = FactoryGirl.create(:lecture_course, :code => "123")
    end

    it "should assign @courses with all the courses, sorted by course code" do
      get :index

      assigns(:courses).size.should == 3
      assigns(:courses).should == [@c3, @c1, @c2]
    end
  end

  describe "GET / show" do
    before :each do
      @c = FactoryGirl.create(:lecture_course)

      @r1 = FactoryGirl.create(:requirement, :lecture_course => @c)
      @r2 = FactoryGirl.create(:requirement, :lecture_course => @c)

      @l1 = FactoryGirl.create(:lecturer, :lecture_course => @c)
      @l2 = FactoryGirl.create(:lecturer, :lecture_course => @c)
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

    it "should assign @lecturers with the staff for the course" do
      get :show, :id => @c

      assigns(:lecturers).size.should == 2
      assigns(:lecturers).should include(@l1, @l2)
    end
  end
end
