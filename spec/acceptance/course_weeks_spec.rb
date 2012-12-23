require 'acceptance/acceptance_helper'

feature "CourseWeeks", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @course1 = FactoryGirl.create(:lecture_course, :code => "123.A", :term => "1, 2")
    @course2 = FactoryGirl.create(:lecture_course, :code => "220",   :term => "2")

    @staff1 = FactoryGirl.create(:staff_member, :login => "abc123", :salutation => "Dr", :firstname => "Testy", :lastname => "McTest")
    @staff2 = FactoryGirl.create(:staff_member, :login => "zyx987", :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein")
    @staff3 = FactoryGirl.create(:staff_member, :login => "jkl456", :salutation => "Prof", :firstname => "Doc", :lastname => "Tor")

    FactoryGirl.create(:lecturer, :staff_member => @staff1, :lecture_course => @course1, :role => "Lecturer")
    FactoryGirl.create(:lecturer, :staff_member => @staff2, :lecture_course => @course1, :role => "Lecturer")
    FactoryGirl.create(:lecturer, :staff_member => @staff3, :lecture_course => @course1, :role => "Organiser")
    FactoryGirl.create(:lecturer, :staff_member => @staff3, :lecture_course => @course2, :role => "Lecturer")

    @year = FactoryGirl.build(:year, :no => 2011)
    @year.terms = [
      FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2011"), :year => @year),
      FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2012"), :year => @year),
      FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("25/04/2012"), :year => @year)
    ]
    @year.save!
  end

  scenario "Can access the course weeks selection page" do
    visit years_page
    page.should have_content("2011")
    click_link("2011")

    current_path.should == year_page(@year)

    page.should have_link("Select Course Weeks")
    click_link("Select Course Weeks")

    # checkboxes have IDs in the form 'coursecode-login-term-week'
    page.should have_field('123-a-abc123-1-1')
    page.should have_field('123-a-zyx987-1-4')
    page.should have_field('123-a-abc123-2-3')
    page.should have_field('123-a-zyx987-2-6')
    page.should have_field('220-jkl456-2-4')

    page.should have_link('123-a-abc123-1-default')
    page.should have_link('123-a-zyx987-2-default')
    page.should have_link('220-jkl456-2-default')

    # The page shouldn't have fields for:
    # - Weeks out of term bounds
    page.should_not have_field('123-a-abc123-1-6')
    page.should_not have_field('123-a-zyx987-2-7')

    # - Terms that it's not taught
    page.should_not have_field('220-jkl456-1-3')
    page.should_not have_field('123-a-abc123-2-default')

    # - Staff who aren't lecturers
    page.should_not have_field('123-a-jkl456-1-1')

    # - Lecturers who don't teach it
    page.should_not have_field('220-abc123-2-4')

    # - Non-existant courses
    page.should_not have_field('330-abc123-3-3')

    page.should have_button("Submit")
  end

  scenario "Can update the weeks for courses", :js => true do
    visit years_page
    click_link("2011")
    click_link("Select Course Weeks")

    check('123-a-abc123-1-2')
    check('123-a-abc123-1-3')
    check('123-a-abc123-1-4')

    check('123-a-zyx987-2-2')
    check('123-a-zyx987-2-3')
    check('123-a-zyx987-2-4')

    click_link('220-jkl456-2-default')

    click_button('Submit')

    page.current_path.should == year_page(@year)
    page.should have_content("Selections were updated successfully.")

    @course1.course_weeks.size.should == 6
    @course2.course_weeks.size.should == 5

    click_link("Select Course Weeks")

    page.should have_checked_field('123-a-abc123-1-2')
    page.should have_checked_field('123-a-abc123-1-3')
    page.should have_checked_field('123-a-abc123-1-4')

    page.should have_checked_field('123-a-zyx987-2-2')
    page.should have_checked_field('123-a-zyx987-2-3')
    page.should have_checked_field('123-a-zyx987-2-4')

    page.should have_checked_field('220-jkl456-2-2')
    page.should have_checked_field('220-jkl456-2-3')
    page.should have_checked_field('220-jkl456-2-4')
    page.should have_checked_field('220-jkl456-2-5')
    page.should have_checked_field('220-jkl456-2-6')

    page.should have_unchecked_field('123-a-abc123-2-1')
    page.should have_unchecked_field('123-a-zyx987-2-1')
    page.should have_unchecked_field('220-jkl456-2-1')
  end
end
