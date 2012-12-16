require 'acceptance/acceptance_helper'

feature "CourseWeeks", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @course1 = FactoryGirl.create(:lecture_course, :code => "123.A", :term => "1, 2")
    @course2 = FactoryGirl.create(:lecture_course, :code => "220",   :term => "2")

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

    # checkboxes have IDs in the form 'coursecode-term-week'
    page.should have_field('123-a-1-1')
    page.should have_field('123-a-1-4')
    page.should have_field('123-a-2-3')
    page.should have_field('123-a-2-6')
    page.should have_field('220-2-4')

    page.should_not have_field('123-a-1-6')
    page.should_not have_field('123-a-2-7')
    page.should_not have_field('220-1-3')
    page.should_not have_field('330-3-3')

    page.should have_button("Submit")
  end

  scenario "Can update the weeks for courses" do
    visit years_page
    click_link("2011")
    click_link("Select Course Weeks")

    check('123-a-1-2')
    check('123-a-1-3')
    check('123-a-1-4')

    check('220-2-2')
    check('220-2-3')
    check('220-2-4')
    check('220-2-5')

    click_button('Submit')

    page.current_path.should == year_page(@year)
    page.should have_content("Selections were updated successfully.")

    @course1.course_weeks.size.should == 3
    @course2.course_weeks.size.should == 4

    click_link("Select Course Weeks")

    page.should have_checked_field('123-a-1-2')
    page.should have_checked_field('123-a-1-3')
    page.should have_checked_field('123-a-1-4')

    page.should have_checked_field('220-2-2')
    page.should have_checked_field('220-2-3')
    page.should have_checked_field('220-2-4')
    page.should have_checked_field('220-2-5')

    page.should have_unchecked_field('123-a-2-1')
    page.should have_unchecked_field('220-2-1')
  end
end
