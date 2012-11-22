require 'acceptance/acceptance_helper'

feature "Lecture Courses", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @course1 = FactoryGirl.create(:lecture_course, :code => "123", :title => "Test Course Number 1")
    @course2 = FactoryGirl.create(:lecture_course, :code => "456", :title => "Test Course Number 2")

    @degree1 = FactoryGirl.create(:degree_class, :title => "Degree Number 1", :degreeyr => "dn11")
    @degree2 = FactoryGirl.create(:degree_class, :title => "Degree Number 2", :degreeyr => "dn21")

    FactoryGirl.create(:requirement, :degree_class => @degree1, :lecture_course => @course1, :required => "Selective2")
  end

  scenario "Can see the lecture courses on the page" do
    visit lecture_courses_page
    page.should have_link("123 - Test Course Number 1")
    page.should have_link("456 - Test Course Number 2")
  end

  scenario "Can view the details of a particular course" do
    visit lecture_courses_page
    click_link("123 - Test Course Number 1")
    current_path.should == lecture_course_page(@course1)
    page.should have_content("123 - Test Course Number 1")
    page.should have_content("Degree Number 1 (Selective2)")
  end
end
