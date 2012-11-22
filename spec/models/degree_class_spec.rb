require 'spec_helper'

describe DegreeClass do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:degreeyr) }
    it { should validate_uniqueness_of(:degreeyr) }

    # Other fields
    it { should validate_presence_of(:letteryr) }
    it { should validate_presence_of(:title) }
  end

  describe "relationships" do
    it { should have_many(:requirements) }
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:degree_class)
      obj.should be_valid
    end
  end

   describe "to_param" do
     it "should return the degreeyr of the object not the id" do
       obj = FactoryGirl.build(:degree_class, :degreeyr => "abc2", :id => 123)
       obj.to_param.should == "abc2"
       obj.to_param.should_not == 123
     end
   end
end
