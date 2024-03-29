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

  describe "scopes" do
    describe "by_degreeyr" do
      it "should return the degrees in degreeyr order" do
        d1 = FactoryGirl.create(:degree_class, :degreeyr => "c1")
        d2 = FactoryGirl.create(:degree_class, :degreeyr => "z4")
        d3 = FactoryGirl.create(:degree_class, :degreeyr => "c3")

        DegreeClass.by_degreeyr.should == [d1, d3, d2]
      end
    end
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
