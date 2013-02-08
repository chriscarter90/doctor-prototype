require 'spec_helper'

describe ClashesController do
  describe "GET / index" do
    before :each do
      @y = FactoryGirl.create(:year, :no => 2011)

      @c1 = FactoryGirl.create(:clash, :year => @y)
      @c2 = FactoryGirl.create(:clash)
      @c3 = FactoryGirl.create(:clash, :year => @y)
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
  end
end
