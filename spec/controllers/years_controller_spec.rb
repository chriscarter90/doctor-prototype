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

  describe "GET / show" do
    before :each do
      @y1 = FactoryGirl.build(:year, :no => 2010)
      @y1.terms = [
                    FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2010"), :year => @y1),
                    FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("24/04/2011"), :year => @y1),
                    FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2011"), :year => @y1)
                  ]
      @y1.save!
    end

    it "should assign @year with the correct room" do
      get :show, :id => @y1

      assigns(:year).should == @y1
    end

    it "should assign @terms with the terms associated with that year in no order" do
      get :show, :id => @y1

      assigns(:terms).size.should == 3
      assigns(:terms).map(&:weeks).map(&:size).should == [4, 6, 5]
    end
  end

  describe "GET / new" do
    it "should assign @year a new year" do
      get :new

      assigns(:year).should be_a_new(Year)
      assigns(:year).terms.size.should == 3
      assigns(:year).terms.each do |t|
        t.should be_a_new(Term)
      end
    end
  end

  describe "POST / create" do
    def create_year(options = {})
      post :create, :year => { :no => 2013, :terms_attributes => { "0" => { :no => 1, :no_weeks => 3, :start_date => Date.parse("01/10/2013") }, "1" => { :no => 2, :no_weeks => 4, :start_date => Date.parse("04/01/2014") }, "2" => { :no => 3, :no_weeks => 6, :start_date => Date.parse("25/04/2014") }}}.merge(options)
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

  describe "GET / edit" do
    before :each do
      @y1 = FactoryGirl.build(:year, :no => 2010)
      @y1.terms = [
                    FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2010"), :year => @y1),
                    FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("24/04/2011"), :year => @y1),
                    FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2011"), :year => @y1)
                  ]
      @y1.save!
    end

    it "should assign @year with the correct room" do
      get :edit, :id => @y1

      assigns(:year).should == @y1
      assigns(:year).terms.in_order.map(&:weeks).map(&:size).should == [4, 6, 5]
    end
  end

  describe "PUT / update" do
    before :each do
      @y1 = FactoryGirl.build(:year, :no => 2010)
      @y1.terms = [
                    FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2010"), :year => @y1),
                    FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("24/04/2011"), :year => @y1),
                    FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2011"), :year => @y1)
                  ]
      @y1.save!
    end

    def do_update(options = {})
      put :update, :id => @y1, :year => { :terms_attributes => { "0" => { :no => 1, :no_weeks => 3, :start_date => Date.parse("02/10/2010") }, "1" => { :no => 3, :no_weeks => 5, :start_date => Date.parse("24/04/2011") }, "2" => { :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2011") }}}.merge(options)
    end

    it "should update the year when successful" do
      do_update

      @y1.reload
      @y1.terms.in_order.map(&:weeks).map(&:size).should == [3, 6, 5]
    end

    it "should not update the year when unsuccessful" do
      do_update(:terms_attributes => { "0" => { :no => 1, :no_weeks => 0, :start_date => Date.parse("02/10/2010") }})

      @y1.terms.in_order.map(&:weeks).map(&:size).should == [4, 6, 5]
    end

    it "should render a flash message when successful" do
      do_update

      flash[:notice].should == "Year was updated successfully."
    end

    it "should render a flash warning when unsuccessful" do
      do_update(:no => "")

      flash[:warning].should == "Year could not be updated."
    end

    it "should redirect to the year when successful" do
      do_update

      response.should redirect_to(year_path(@y1))
    end

    it "should render the edit template when unsuccessful" do
      do_update(:no => "")

      response.should render_template(:edit)
    end
  end
end
