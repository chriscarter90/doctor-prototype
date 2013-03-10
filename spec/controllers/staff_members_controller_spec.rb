require 'spec_helper'

describe StaffMembersController do
  describe "GET / index" do
    before :each do
      @y = FactoryGirl.create(:year, :no => 2011)

      @s1 = FactoryGirl.create(:staff_member, :login => "abc124", :year => @y)
      @s2 = FactoryGirl.create(:staff_member, :login => "xyz789", :year => @y)
      @s3 = FactoryGirl.create(:staff_member, :login => "abc123", :year => @y)
    end

    it "should assign @staff with all the staff, ordered by login" do
      get :index, :year_id => @y.to_param

      assigns(:staff).size.should == 3
      assigns(:staff).should == [@s3, @s1, @s2]
    end
  end

  describe "GET / show" do
    before :each do
      @y = FactoryGirl.create(:year, :no => 2011)

      @s = FactoryGirl.create(:staff_member, :year => @y)

      @l1 = FactoryGirl.create(:lecturer, :staff_member => @s)
      @l2 = FactoryGirl.create(:lecturer, :staff_member => @s)
    end

    it "should assign @staff_member with the correct staff member" do
      get :show, :year_id => @y.to_param, :id => @s

      assigns(:staff_member).should == @s
    end

    it "should assign @lecturers with the requirements for the degree" do
      get :show, :year_id => @y.to_param, :id => @s

      assigns(:lecturers).size.should == 2
      assigns(:lecturers).should include(@l1, @l2)
    end
  end
end
