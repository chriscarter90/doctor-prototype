require 'spec_helper'

describe DegreeClassesController do
  describe "GET / index" do
    before :each do
      @y = FactoryGirl.create(:year, :no => 2011)

      @d1 = FactoryGirl.create(:degree_class, :degreeyr => "c1", :year => @y)
      @d2 = FactoryGirl.create(:degree_class, :degreeyr => "z4", :year => @y)
      @d3 = FactoryGirl.create(:degree_class, :degreeyr => "c3", :year => @y)
    end

    it "should assign @courses with all the degrees, ordered by degreeyr" do
      get :index, :year_id => @y.to_param

      assigns(:degrees).size.should == 3
      assigns(:degrees).should == [@d1, @d3, @d2]
    end
  end

  describe "GET / show" do
    before :each do
      @y = FactoryGirl.create(:year, :no => 2011)

      @d = FactoryGirl.create(:degree_class, :year => @y)

      @r1 = FactoryGirl.create(:requirement, :degree_class => @d)
      @r2 = FactoryGirl.create(:requirement, :degree_class => @d)
    end

    it "should assign @degree with the correct degree" do
      get :show, :year_id => @y.to_param, :id => @d

      assigns(:degree).should == @d
    end

    it "should assign @requirements with the requirements for the degree" do
      get :show, :year_id => @y.to_param, :id => @d

      assigns(:requirements).size.should == 2
      assigns(:requirements).should include(@r1, @r2)
    end
  end
end
