require 'spec_helper'

describe Term do
  describe "validations" do
    it { should validate_presence_of(:no) }
    it { should validate_presence_of(:year) }
  end

  describe "relationships" do
    it { should belong_to(:year) }
    it { should have_many(:weeks) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:term)
      obj.should be_valid
    end
  end
end
