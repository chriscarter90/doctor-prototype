require 'acceptance/acceptance_helper'

feature "Staff Members", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @staff_member1 = FactoryGirl.create(:staff_member, :login => "abc123", :salutation => "Mr", :firstname => "Testy", :lastname => "McTest")
    @staff_member2 = FactoryGirl.create(:staff_member, :login => "xyz789", :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein")

    @course1 = FactoryGirl.create(:lecture_course, :code => "123", :title => "Test Course Number 1")

    FactoryGirl.create(:lecturer, :staff_member => @staff_member1, :lecture_course => @course1, :role => "Lecturer")
  end

  scenario "Can see the staff members on the page" do
    visit staff_members_page
    page.should have_link("abc123 - Mr Testy McTest")
    page.should have_link("xyz789 - Dr Frank EnStein")
  end

  scenario "Can view the details of a particular degree" do
    # Visiting a staff member who teaches
    visit staff_members_page
    click_link("abc123 - Mr Testy McTest")
    current_path.should == staff_member_page(@staff_member1)
    page.should have_content("abc123 - Mr Testy McTest")
    page.should have_content("Test Course Number 1")
    page.should have_content("Lecturer")

    # Visiting the course associated with the requirement
    page.should have_link("Test Course Number 1")
    click_link("Test Course Number 1")
    current_path.should == lecture_course_page(@course1)

    # Visiting a degree with no requirements
    visit staff_members_page
    click_link("xyz789 - Dr Frank EnStein")
    current_path.should == staff_member_page(@staff_member2)
    page.should have_content("xyz789 - Dr Frank EnStein")
    page.should have_content("There are no courses for this staff member.")
  end
end
