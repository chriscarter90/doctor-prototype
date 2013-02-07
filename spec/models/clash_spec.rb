require 'spec_helper'

describe Clash do
  describe "validations" do
    it { should validate_presence_of(:year) }
  end

  describe "relationships" do
    it { should have_and_belong_to_many(:lecture_courses) }
    it { should belong_to(:year) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.create(:clash)
      obj.should be_valid
    end
  end
end
