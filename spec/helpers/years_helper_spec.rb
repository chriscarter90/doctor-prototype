require 'spec_helper'

describe YearsHelper do
  describe "start_date" do
    it "should return the start date of a term in a nice format" do
      term = FactoryGirl.create(:term, :start_date => Date.parse("07/08/1993"))

      helper.start_date(term).should == "7 August 1993"
    end
  end
end
