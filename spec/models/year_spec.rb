require 'spec_helper'

describe Year do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:no) }
    it { should validate_uniqueness_of(:no) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:year)
      obj.should be_valid
    end
  end
end
