require 'acceptance/acceptance_helper'

feature "Home Page", %q{
  In order ...
  As ...
  I want to ...
} do

  scenario "I can access the degree classes page" do
    visit home_page
    page.should have_link("Degree Classes")
    click_link("Degree Classes")
    current_path.should == degree_classes_page
  end

  scenario "I can access the lecture courses page" do
    visit home_page
    page.should have_link("Lecture Courses")
    click_link("Lecture Courses")
    current_path.should == lecture_courses_page
  end

  scenario "I can access the staff members page" do
    visit home_page
    page.should have_link("Staff Members")
    click_link("Staff Members")
    current_path.should == staff_members_page
  end

  scenario "I can access the rooms page" do
    visit home_page
    page.should have_link("Rooms")
    click_link("Rooms")
    current_path.should == rooms_page
  end
end
