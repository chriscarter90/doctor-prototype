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

  describe "GET / edit" do
    before :each do
      @r = FactoryGirl.create(:room, :no => 308, :capacity => 200)
    end

    it "should assign @room with the right room" do
      get :edit, :id => @r

      assigns(:room).should == @r
    end
  end

  describe "PUT / update" do
    before :each do
      @r = FactoryGirl.create(:room, :no => 308, :capacity => 200)
    end

    def do_update(options = {})
      put :update, :id => @r, :room => { :capacity => 100 }.merge!(options)
    end

    it "should update the room when successful" do
      do_update

      @r.reload
      @r.capacity.should == 100
    end

    it "should not update the room when unsuccessful" do
      do_update(:capacity => "")

      @r.capacity.should == 200
    end

    it "should render a flash message when successful" do
      do_update

      flash[:notice].should == "Room was successfully updated."
    end

    it "should render a flash warning when unsuccessful" do
      do_update(:capacity => "")

      flash[:warning].should == "Room could not be updated."
    end

    it "should redirect to the rooms index when successful" do
      do_update

      response.should redirect_to(rooms_path)
    end

    it "should render the edit template when unsuccessful" do
      do_update(:capacity => "")

      response.should render_template(:edit)
    end
  end
end
