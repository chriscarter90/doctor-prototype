require 'spec_helper'

describe DegreeClassesController do
  describe "GET / index" do
    before :each do
      @d1 = FactoryGirl.create(:degree_class, :degreeyr => "c1")
      @d2 = FactoryGirl.create(:degree_class, :degreeyr => "z4")
      @d3 = FactoryGirl.create(:degree_class, :degreeyr => "c3")
    end

    it "should assign @courses with all the degrees, ordered by degreeyr" do
      get :index

      assigns(:degrees).size.should == 3
      assigns(:degrees).should == [@d1, @d3, @d2]
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
