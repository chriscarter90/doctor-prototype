require 'spec_helper'

describe Lecturer do
  describe "validations" do
    it { should validate_presence_of(:staff_member) }
    it { should validate_presence_of(:lecture_course) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:staffhours) }
    it { should validate_presence_of(:term) }
  end

  describe "relationships" do
    it { should belong_to(:staff_member) }
    it { should belong_to(:lecture_course) }
  end

  describe "scopes" do
    describe "only_lecturers" do
      it "should return only those with the Lecturer role" do
        @l1 = FactoryGirl.create(:lecturer, :role => "Lecturer")
        @l2 = FactoryGirl.create(:lecturer, :role => "Organiser")
        @l3 = FactoryGirl.create(:lecturer, :role => "Lab Organiser")
        @l4 = FactoryGirl.create(:lecturer, :role => "Lecturer")
        @l5 = FactoryGirl.create(:lecturer, :role => "Organiser")

        Lecturer.only_lecturers.should include(@l1, @l4)
        Lecturer.only_lecturers.should_not include(@l2, @l3, @l5)
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:lecturer)
      obj.should be_valid
    end
  end
end
