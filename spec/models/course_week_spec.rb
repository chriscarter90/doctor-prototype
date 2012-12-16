require 'spec_helper'

describe CourseWeek do
  describe "validations" do
    it { should validate_presence_of(:week) }
    it { should validate_presence_of(:staff_member) }
    it { should validate_presence_of(:lecture_course) }
  end

  describe "relationships" do
    it { should belong_to(:week) }
    it { should belong_to(:staff_member) }
    it { should belong_to(:lecture_course) }
  end

  describe "scopes" do
    describe "for_year" do
      before :each do
        @year1 = FactoryGirl.build(:year, :no => 2011)
        @year1.terms = [
                         FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2011"), :year => @year1),
                         FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2012"), :year => @year1),
                         FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("25/04/2012"), :year => @year1)
                       ]
        @year1.save!

        @year2 = FactoryGirl.build(:year, :no => 2012)
        @year2.terms = [
                         FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2012"), :year => @year2),
                         FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2013"), :year => @year2),
                         FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("25/04/2013"), :year => @year2)
                       ]
        @year2.save!

        @cw1 = FactoryGirl.create(:course_week, :week => @year1.terms.sample.weeks.sample)
        @cw2 = FactoryGirl.create(:course_week, :week => @year1.terms.sample.weeks.sample)
        @cw3 = FactoryGirl.create(:course_week, :week => @year1.terms.sample.weeks.sample)
        @cw4 = FactoryGirl.create(:course_week, :week => @year2.terms.sample.weeks.sample)
        @cw5 = FactoryGirl.create(:course_week, :week => @year2.terms.sample.weeks.sample)
      end

      it "should return only the CourseWeeks for the provided year" do
        CourseWeek.for_year(@year1).should include(@cw1, @cw2, @cw3)
        CourseWeek.for_year(@year1).should_not include(@cw4, @cw5)

        CourseWeek.for_year(@year2).should_not include(@cw1, @cw2, @cw3)
        CourseWeek.for_year(@year2).should include(@cw4, @cw5)
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.create(:course_week)
      obj.should be_valid
    end
  end
end
