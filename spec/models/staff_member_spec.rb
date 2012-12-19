require 'spec_helper'

describe StaffMember do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:login) }
    it { should validate_uniqueness_of(:login) }

    # Other fields
    it { should validate_presence_of(:salutation) }
    it { should validate_presence_of(:firstname) }
    it { should validate_presence_of(:lastname) }
  end

  describe "relationships" do
    it { should have_many(:lecturers) }
    it { should have_many(:lecture_courses).through(:lecturers) }
    it { should have_many(:course_weeks) }
  end

  describe "scopes" do
    describe "by_login" do
      it "should return staff members sorted by login" do
        s1 = FactoryGirl.create(:staff_member, :login => "abc124")
        s2 = FactoryGirl.create(:staff_member, :login => "xyz789")
        s3 = FactoryGirl.create(:staff_member, :login => "abc123")

        StaffMember.by_login.should == [s3, s1, s2]
      end
    end
  end

  describe "factory" do
    it "should return a valid object" do
      obj = FactoryGirl.build(:staff_member)
      obj.should be_valid
    end
  end

  describe "to_param" do
    it "should return the staff login and not its id" do
      obj = FactoryGirl.build(:staff_member, :id => 123, :login => "abc123")
      obj.to_param.should == "abc123"
      obj.to_param.should_not == 123
    end
  end

  describe "full_name" do
    it "should return the salutation, first name and last name" do
      s = FactoryGirl.create(:staff_member, :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein")

      s.full_name.should == "Dr Frank EnStein"
    end
  end

  describe "display" do
    it "should return the salutation, first name, last and and login" do
      s = FactoryGirl.create(:staff_member, :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein", :login => "fs100")

      s.display.should == "Dr Frank EnStein (fs100)"
    end
  end
end
