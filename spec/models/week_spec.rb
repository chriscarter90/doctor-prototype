require 'spec_helper'

describe Week do
  describe "validations" do
    it { should validate_presence_of(:no) }
    it { should validate_presence_of(:term) }
  end

  describe "relationships" do
    it { should belong_to(:term) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:week)
      obj.should be_valid
    end
  end
end
