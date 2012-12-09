require 'spec_helper'

describe Term do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:no) }

    # Other fields
    it { should validate_presence_of(:year) }
  end

  describe "relationships" do
    it { should belong_to(:year) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.create(:term)
      obj.should be_valid
    end
  end
end
