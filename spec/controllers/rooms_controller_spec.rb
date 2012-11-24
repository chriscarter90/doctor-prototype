require 'spec_helper'

describe RoomsController do
  describe "GET / index" do
    before :each do
      @r1 = FactoryGirl.create(:room, :no => 308)
      @r2 = FactoryGirl.create(:room, :no => 201)
      @r3 = FactoryGirl.create(:room, :no => 301)
    end

    it "should assign @rooms with all the rooms, ordered by no" do
      get :index

      assigns(:rooms).size.should == 3
      assigns(:rooms).should == [@r2, @r3, @r1]
    end
  end
end
