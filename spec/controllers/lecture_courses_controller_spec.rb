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
end
