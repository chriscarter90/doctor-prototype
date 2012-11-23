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

end
