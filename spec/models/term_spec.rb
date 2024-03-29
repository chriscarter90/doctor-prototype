require 'spec_helper'

describe Term do
  describe "validations" do
    it { should validate_presence_of(:no) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:start_date) }

    it "should have at least one week" do
      t = FactoryGirl.build(:term, :no_weeks => 0)
      t.should_not be_valid

      t = FactoryGirl.build(:term, :no_weeks => 3)
      t.should be_valid
    end
  end

  describe "relationships" do
    it { should belong_to(:year) }
    it { should have_many(:weeks).dependent(:destroy) }
    it { should have_many(:course_weeks).through(:weeks) }
  end

  describe "scopes" do
    describe "in_order" do
      it "should return the terms in chronological order" do
        t1 = FactoryGirl.create(:term, :no => 2)
        t2 = FactoryGirl.create(:term, :no => 3)
        t3 = FactoryGirl.create(:term, :no => 1)

        Term.in_order.should == [t3, t1, t2]
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:term)
      obj.should be_valid
    end
  end

  describe "before_save" do
    it "should create the number of weeks required" do
      t = FactoryGirl.build(:term, :no_weeks => 4)
      t.save!
      t.weeks.size.should == 4
    end

    it "should not create new weeks if the number of weeks remains the same when updated" do
      t = FactoryGirl.create(:term, :no_weeks => 4)
      t.weeks.size.should == 4
      week_ids = t.weeks.map(&:id)

      t.no_weeks = 4
      t.save!
      t.weeks.map(&:id).should == week_ids
    end

    it "should add additional weeks if updating to have more" do
      t = FactoryGirl.create(:term, :no_weeks => 4)
      t.weeks.size.should == 4
      week_ids = t.weeks.map(&:id)

      t.no_weeks = 6
      t.save!
      t.weeks.map(&:id)[0..3].should == week_ids
    end

    it "should have the first week on the same day as the start date if it's a Monday" do
      monday = Date.parse("02/01/2012")
      t = FactoryGirl.create(:term, :no_weeks => 4, :start_date => monday)
      t.weeks.first.date.should == monday
    end

    it "should have the first week on the next Monday from the start date if it's not a Monday" do
      wednesday = Date.parse("04/01/2012")
      next_monday = (wednesday + 1.weeks).beginning_of_week
      t = FactoryGirl.create(:term, :no_weeks => 4, :start_date => wednesday)
      t.weeks.first.date.should == next_monday
    end
  end
end
