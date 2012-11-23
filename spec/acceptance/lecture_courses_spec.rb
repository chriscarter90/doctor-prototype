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

    @staff1 = FactoryGirl.create(:staff_member, :login => "abc123", :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein")

    FactoryGirl.create(:requirement, :degree_class => @degree1, :lecture_course => @course1, :required => "Selective2")
    FactoryGirl.create(:lecturer, :lecture_course => @course1, :staff_member => @staff1, :role => "Lecturer")
  end

  scenario "Can see the lecture courses on the page" do
    visit lecture_courses_page
    page.should have_link("123 - Test Course Number 1")
    page.should have_link("456 - Test Course Number 2")
  end

  scenario "Can view the details of a particular course" do
    # Visiting a course with requirements
    visit lecture_courses_page
    click_link("123 - Test Course Number 1")
    current_path.should == lecture_course_page(@course1)
    page.should have_content("123 - Test Course Number 1")
    page.should have_content("Degree Number 1")
    page.should have_content("Selective2")
    page.should have_content("Dr Frank EnStein")
    page.should have_content("Lecturer")

    # Visiting the degree associated with the requirement
    page.should have_link("Degree Number 1")
    click_link("Degree Number 1")
    current_path.should == degree_class_page(@degree1)

    # Visiting the staff member associated with the course
    click_link("Test Course Number 1")
    page.should have_link("Dr Frank EnStein")
    click_link("Dr Frank EnStein")
    current_path.should == staff_member_page(@staff1)

    # Visiting a course with no requirements
    visit lecture_courses_page
    click_link("456 - Test Course Number 2")
    current_path.should == lecture_course_page(@course2)
    page.should have_content("456 - Test Course Number 2")
    page.should have_content("There are no requirements for this course.")
    page.should have_content("There are no staff members for this course.")
  end
end
