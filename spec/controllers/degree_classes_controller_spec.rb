require 'spec_helper'

describe DegreeClassesController do
  describe "GET / index" do
    before :each do
      @d1 = FactoryGirl.create(:degree_class)
      @d2 = FactoryGirl.create(:degree_class)
      @d3 = FactoryGirl.create(:degree_class)
    end

    it "should assign @courses with all the courses" do
      get :index

      assigns(:degrees).size.should == 3
      assigns(:degrees).should include(@d1, @d2, @d3)
    end
  end

  describe "GET / show" do
    before :each do
      @d = FactoryGirl.create(:degree_class)
    end

    it "should assign @course with the correct course" do
      get :show, :id => @d

      assigns(:degree).should == @d
    end
  end
end
