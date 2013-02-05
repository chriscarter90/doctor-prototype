require 'spec_helper'

describe Clash do
  describe "validations" do
    it { should validate_presence_of(:a_course) }
    it { should validate_presence_of(:b_course) }
    it { should validate_presence_of(:year) }
  end

  describe "relationships" do
    it { should belong_to(:a_course) }
    it { should belong_to(:b_course) }
    it { should belong_to(:year) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.create(:clash)
      obj.should be_valid
    end
  end
end
