require 'spec_helper'

describe Requirement do
  describe "validations" do
    it { should validate_presence_of(:degree_class) }
    it { should validate_presence_of(:lecture_course) }
    it { should validate_presence_of(:required) }
  end

  describe "relationships" do
    it { should belong_to(:degree_class) }
    it { should belong_to(:lecture_course) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:requirement)
      obj.should be_valid
    end
  end
end
