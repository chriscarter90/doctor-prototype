require 'spec_helper'

describe CourseWeeksController do
  describe "index" do
    before :each do
      @year = FactoryGirl.build(:year)
      @year.terms = [
                      FactoryGirl.create(:term, :no => 1, :year => @year),
                      FactoryGirl.create(:term, :no => 3, :year => @year),
                      FactoryGirl.create(:term, :no => 2, :year => @year)
                    ]
      @year.save!

      @c1 = FactoryGirl.create(:lecture_course, :code => "123B")
      @c2 = FactoryGirl.create(:lecture_course, :code => "101")

      get :index, :year_id => @year
    end

    it "should assign @year with the correct year" do
      assigns(:year).should == @year
    end

    it "should assign @terms with the terms for the year (in order)" do
      assigns(:terms).size.should == 3
      assigns(:terms).map(&:no).should == [1, 2, 3]
    end

    it "should assign @courses with all of the courses (in order)" do
      assigns(:courses).should == [@c2, @c1]
    end
  end

  describe "udpate" do
    before :each do
      @year = FactoryGirl.build(:year)
      @year.terms = [
                      FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :year => @year),
                      FactoryGirl.create(:term, :no => 3, :no_weeks => 6, :year => @year),
                      FactoryGirl.create(:term, :no => 2, :no_weeks => 5, :year => @year)
                    ]
      @year.save!

      @c1 = FactoryGirl.create(:lecture_course, :code => "123B", :term => "1")
      @c2 = FactoryGirl.create(:lecture_course, :code => "101", :term => "2")
    end

    it "should assign @year with the correct year" do
      get :update, :year_id => @year

      assigns(:year).should == @year
    end

    it "should clear out all week allocations for blank params" do
      get :update, :year_id => @year

      @year.course_weeks.should be_empty
      @c1.course_weeks.for_year(@year).should be_empty
      @c2.course_weeks.should be_empty
    end

    it "should create allocations based on the params if everything is valid" do
      get :update, :year_id => @year, :course_weeks => { "123B" => { "1" => ["1", "2"] }, "101" => { "2" => [ "2", "3", "4" ] } }

      @year.course_weeks.for_year(@year).size.should == 5
      @c1.course_weeks.size.should == 2
      @c2.course_weeks.size.should == 3
    end

    it "should not create an allocation for a week which doesn't exist within the term" do
      get :update, :year_id => @year, :course_weeks => { "123B" => { "1" => ["1", "5"] }, "101" => { "2" => [ "2", "6" ] } }

      @year.course_weeks.for_year(@year).size.should == 2
      @c1.course_weeks.size.should == 1
      @c2.course_weeks.size.should == 1
    end

    it "should not create an allocation for a term in which the course is not meant to be taught" do
      get :update, :year_id => @year, :course_weeks => { "123B" => { "1" => [ "1", "2", "3" ], "2" => [ "1", "2", "3" ] } }

      @year.course_weeks.for_year(@year).size.should == 3
      @c1.course_weeks.size.should == 3
      @c2.course_weeks.size.should == 0
    end
  end
end
