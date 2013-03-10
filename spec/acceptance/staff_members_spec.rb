require 'acceptance/acceptance_helper'

feature "Staff Members", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @year = FactoryGirl.create(:year, :no => 2011)

    @staff_member1 = FactoryGirl.create(:staff_member, :login => "abc123", :salutation => "Mr", :firstname => "Testy", :lastname => "McTest", :year => @year)
    @staff_member2 = FactoryGirl.create(:staff_member, :login => "xyz789", :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein", :year => @year)

    @course1 = FactoryGirl.create(:lecture_course, :code => "123", :title => "Test Course Number 1", :year => @year)

    FactoryGirl.create(:lecturer, :staff_member => @staff_member1, :lecture_course => @course1, :role => "Lecturer")
  end

  scenario "I can access the staff members page" do
    visit year_page(@year)
    page.should have_link("Staff Members")
    click_link("Staff Members")
    current_path.should == staff_members_page(@year)
  end

  scenario "Can see the staff members on the page" do
    visit staff_members_page(@year)
    page.should have_link("abc123 - Mr Testy McTest")
    page.should have_link("xyz789 - Dr Frank EnStein")
  end

  scenario "Can view the details of a particular degree" do
    # Visiting a staff member who teaches
    visit staff_members_page(@year)
    click_link("abc123 - Mr Testy McTest")
    current_path.should == staff_member_page(@year, @staff_member1)
    page.should have_content("abc123 - Mr Testy McTest")
    page.should have_content("Test Course Number 1")
    page.should have_content("Lecturer")

    # Visiting the course associated with the requirement
    page.should have_link("Test Course Number 1")
    click_link("Test Course Number 1")
    current_path.should == lecture_course_page(@year, @course1)

    # Visiting a degree with no requirements
    visit staff_members_page(@year)
    click_link("xyz789 - Dr Frank EnStein")
    current_path.should == staff_member_page(@year, @staff_member2)
    page.should have_content("xyz789 - Dr Frank EnStein")
    page.should have_content("There are no courses for this staff member.")
  end
end
