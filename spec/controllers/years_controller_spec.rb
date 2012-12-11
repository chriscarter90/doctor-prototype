require 'spec_helper'

describe YearsController do
  describe "GET / index" do
    before :each do
      @y1 = FactoryGirl.create(:year, :no => 2010)
      @y2 = FactoryGirl.create(:year, :no => 2012)
      @y3 = FactoryGirl.create(:year, :no => 2009)
    end

    it "should assign @rooms with all the rooms, ordered by no" do
      get :index

      assigns(:years).size.should == 3
      assigns(:years).should == [@y3, @y1, @y2]
    end
  end
end
