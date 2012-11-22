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

      @r1 = FactoryGirl.create(:requirement, :degree_class => @d)
      @r2 = FactoryGirl.create(:requirement, :degree_class => @d)
    end

    it "should assign @degree with the correct degree" do
      get :show, :id => @d

      assigns(:degree).should == @d
    end

    it "should assign @requirements with the requirements for the degree" do
      get :show, :id => @d

      assigns(:requirements).size.should == 2
      assigns(:requirements).should include(@r1, @r2)
    end
  end
end
