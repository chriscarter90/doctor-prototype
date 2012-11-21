require 'acceptance/acceptance_helper'

feature "Lecture Courses", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @course1 = FactoryGirl.create(:lecture_course, :code => "123", :title => "Test Course Number 1")
    @course2 = FactoryGirl.create(:lecture_course, :code => "456", :title => "Test Course Number 2")
  end

  scenario "Can see the lecture courses on the page" do
    visit lecture_courses_page
    page.should have_content("Test Course Number 1")
    page.should have_content("Test Course Number 2")
  end
end
