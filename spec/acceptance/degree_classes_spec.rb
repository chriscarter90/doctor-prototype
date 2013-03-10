require 'acceptance/acceptance_helper'

feature "Degree Classes", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @year = FactoryGirl.create(:year, :no => 2011)

    @degree1 = FactoryGirl.create(:degree_class, :title => "Degree Number 1", :degreeyr => "dn11", :year => @year)
    @degree2 = FactoryGirl.create(:degree_class, :title => "Degree Number 2", :degreeyr => "dn21", :year => @year)

    @course1 = FactoryGirl.create(:lecture_course, :code => "123", :title => "Test Course Number 1", :year => @year)

    FactoryGirl.create(:requirement, :degree_class => @degree1, :lecture_course => @course1, :required => "Selective2")
  end

  scenario "I can access the degree classes page for a year" do
    visit year_page(@year)
    page.should have_link("Degree Classes")
    click_link("Degree Classes")
    current_path.should == degree_classes_page(@year)
  end

  scenario "Can see the degree classes on the page" do
    visit degree_classes_page(@year)
    page.should have_link("dn11 - Degree Number 1")
    page.should have_link("dn21 - Degree Number 2")
  end

  scenario "Can view the details of a particular degree" do
    # Visiting a degree with requirements
    visit degree_classes_page(@year)
    click_link("dn11 - Degree Number 1")
    current_path.should == degree_class_page(@year, @degree1)
    page.should have_content("dn11 - Degree Number 1")
    page.should have_content("Test Course Number 1")
    page.should have_content("Selective2")

    # Visiting the course associated with the requirement
    page.should have_link("Test Course Number 1")
    click_link("Test Course Number 1")
    current_path.should == lecture_course_page(@year, @course1)

    # Visiting a degree with no requirements
    visit degree_classes_page(@year)
    click_link("dn21 - Degree Number 2")
    current_path.should == degree_class_page(@year, @degree2)
    page.should have_content("dn21 - Degree Number 2")
    page.should have_content("There are no requirements for this degree.")
  end
end
