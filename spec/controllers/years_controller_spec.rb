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

  describe "GET / new" do
    it "should assign @year a new year" do
      get :new

      assigns(:year).should be_a_new(Year)
    end

    it "should create 3 new terms" do
      get :new
      assigns(:terms).size.should == 3
      assigns(:terms).each do |t|
        t.should be_a_new(Term)
      end
    end
  end

  describe "POST / create" do
    def create_year(options = {})
      post :create, :year => { :no => 2013, :terms_attributes => { "0" => { :no => 1, :no_weeks => 3 }, "1" => { :no => 2, :no_weeks => 4 }, "2" => { :no => 3, :no_weeks => 6 }}}.merge(options)
    end

    it "should create a new year when successful" do
      create_year

      Year.count.should == 1
    end

    it "should not create a new year when unsuccessful" do
      create_year(:no => "")

      Year.count.should == 0
    end

    it "should render a flash notice when successful" do
      create_year

      flash[:notice].should == "Year was created successfully."
    end

    it "should render a flash warning when unsuccessful" do
      create_year(:no => "")

      flash[:warning].should == "Year could not be created."
    end

    it "should redirect to the years page when successful" do
      create_year

      response.should redirect_to(years_path)
    end

    it "should render the new template when unsuccessful" do
      create_year(:no => "")

      response.should render_template(:new)
    end
  end
end
