require 'acceptance/acceptance_helper'

feature "Degree Classes", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @degree1 = FactoryGirl.create(:degree_class, :title => "Degree Number 1", :degreeyr => "dn11")
    @degree2 = FactoryGirl.create(:degree_class, :title => "Degree Number 2", :degreeyr => "dn21")

    @course1 = FactoryGirl.create(:lecture_course, :code => "123", :title => "Test Course Number 1")
    @course2 = FactoryGirl.create(:lecture_course, :code => "456", :title => "Test Course Number 2")

    FactoryGirl.create(:requirement, :degree_class => @degree1, :lecture_course => @course1, :required => "Selective2")
  end

  scenario "Can see the degree classes on the page" do
    visit degree_classes_page
    page.should have_link("dn11 - Degree Number 1")
    page.should have_link("dn21 - Degree Number 2")
  end

  scenario "Can view the details of a particular degree" do
    visit degree_classes_page
    click_link("dn11 - Degree Number 1")
    current_path.should == degree_class_page(@degree1)
    page.should have_content("dn11 - Degree Number 1")
    page.should have_content("Test Course Number 1 (Selective2)")
  end
end
