require 'acceptance/acceptance_helper'

feature "CourseWeeks", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @year = FactoryGirl.create(:year, :no => 2011)

    @course1 = FactoryGirl.create(:lecture_course, :code => "123.A", :term => "1, 2", :year => @year)
    @course2 = FactoryGirl.create(:lecture_course, :code => "220",   :term => "2", :year => @year)

    @staff1 = FactoryGirl.create(:staff_member, :login => "abc123", :salutation => "Dr", :firstname => "Testy", :lastname => "McTest", :year => @year)
    @staff2 = FactoryGirl.create(:staff_member, :login => "zyx987", :salutation => "Dr", :firstname => "Frank", :lastname => "EnStein", :year => @year)
    @staff3 = FactoryGirl.create(:staff_member, :login => "jkl456", :salutation => "Prof", :firstname => "Doc", :lastname => "Tor", :year => @year)

    FactoryGirl.create(:lecturer, :staff_member => @staff1, :lecture_course => @course1, :role => "Lecturer")
    FactoryGirl.create(:lecturer, :staff_member => @staff2, :lecture_course => @course1, :role => "Lecturer")
    FactoryGirl.create(:lecturer, :staff_member => @staff3, :lecture_course => @course1, :role => "Organiser")
    FactoryGirl.create(:lecturer, :staff_member => @staff3, :lecture_course => @course2, :role => "Lecturer")

    @year.terms = [
      FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2011"), :year => @year),
      FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2012"), :year => @year),
      FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("25/04/2012"), :year => @year)
    ]
    @year.save!
  end

  scenario "Can access the course weeks selection page", :js => true do
    visit years_page
    page.should have_content("2011")
    click_link("2011")

    current_path.should == year_page(@year)

    page.should have_link("Select Course Weeks")
    click_link("Select Course Weeks")

    # checkboxes have IDs in the form 'coursecode-login-term-week'
    within(:css, "div#123-a") do
      page.should have_field("merge")
      page.should have_field("1-1-abc123")
      page.should have_field("1-2-abc123")
      page.should have_field("1-3-abc123")
      page.should have_field("1-4-abc123")

      page.should have_field("2-1-abc123")
      page.should have_field("2-2-abc123")
      page.should have_field("2-3-abc123")
      page.should have_field("2-4-abc123")
      page.should have_field("2-5-abc123")
      page.should have_field("2-6-abc123")

      page.should have_field("1-1-zyx987")
      page.should have_field("1-2-zyx987")
      page.should have_field("1-3-zyx987")
      page.should have_field("1-4-zyx987")

      page.should have_field("2-1-zyx987")
      page.should have_field("2-2-zyx987")
      page.should have_field("2-3-zyx987")
      page.should have_field("2-4-zyx987")
      page.should have_field("2-5-zyx987")
      page.should have_field("2-6-zyx987")

      page.should have_field("1-1-all")
      page.should have_field("1-2-all")
      page.should have_field("1-3-all")
      page.should have_field("1-4-all")

      page.should have_field("2-1-all")
      page.should have_field("2-2-all")
      page.should have_field("2-3-all")
      page.should have_field("2-4-all")
      page.should have_field("2-5-all")
      page.should have_field("2-6-all")

      page.should have_field("1-1-tutorial")
      page.should have_field("1-2-tutorial")
      page.should have_field("1-3-tutorial")
      page.should have_field("1-4-tutorial")

      page.should have_field("2-1-tutorial")
      page.should have_field("2-2-tutorial")
      page.should have_field("2-3-tutorial")
      page.should have_field("2-4-tutorial")
      page.should have_field("2-5-tutorial")
      page.should have_field("2-6-tutorial")

      page.should have_field("1-1-lab")
      page.should have_field("1-2-lab")
      page.should have_field("1-3-lab")
      page.should have_field("1-4-lab")

      page.should have_field("2-1-lab")
      page.should have_field("2-2-lab")
      page.should have_field("2-3-lab")
      page.should have_field("2-4-lab")
      page.should have_field("2-5-lab")
      page.should have_field("2-6-lab")

      page.should_not have_field("3-1-abc123")
      page.should_not have_field("3-2-zyx987")
      page.should_not have_field("1-5-abc123")
      page.should_not have_field("2-7-abc123")
      page.should_not have_field("2-7-all")
      page.should_not have_field("3-2-tutorial")
      page.should_not have_field("3-4-lab")
      page.should_not have_field("1-5-jkl456")

      page.should have_link("1-abc123-defaults")
      page.should have_link("1-zyx987-defaults")
      page.should have_link("2-abc123-defaults")
      page.should have_link("2-zyx987-defaults")
      page.should_not have_link("3-abc123-defaults")
      page.should_not have_link("3-zyx987-defaults")
      page.should have_link("1-all-defaults")
      page.should have_link("2-all-defaults")
    end

    page.should have_button("Submit")
  end

  scenario "Can update the weeks for courses", :js => true do
    visit years_page
    click_link("2011")
    click_link("Select Course Weeks")

    within(:css, "div#123-a") do
      fill_in('1-1-abc123', :with => "2")
      fill_in('1-2-abc123', :with => "2")
      fill_in('1-3-abc123', :with => "2")
      fill_in('1-4-abc123', :with => "2")

      click_link("1-zyx987-defaults")

      fill_in('1-1-tutorial', :with => "1")
      fill_in('1-2-tutorial', :with => "1")
      fill_in('1-3-tutorial', :with => "1")
      fill_in('1-4-tutorial', :with => "1")
    end

    click_button('Submit')

    page.current_path.should == year_page(@year)
    page.should have_content("Selections were updated successfully.")

    @course1.course_weeks.size.should == 40 # rows with 0s are stored, TODO: change this
    @course2.course_weeks.size.should == 18

    click_link("Select Course Weeks")

    within(:css, "div#123-a") do
      page.should have_unchecked_field("merge")

      page.should have_field('1-1-abc123', :text => "2")
      page.should have_field('1-2-abc123', :text => "2")
      page.should have_field('1-3-abc123', :text => "2")
      page.should have_field('1-4-abc123', :text => "2")

      page.should have_field('2-1-abc123', :text => "0")
      page.should have_field('2-2-abc123', :text => "0")
      page.should have_field('2-3-abc123', :text => "0")
      page.should have_field('2-4-abc123', :text => "0")
      page.should have_field('2-5-abc123', :text => "0")
      page.should have_field('2-6-abc123', :text => "0")

      page.should have_field('1-1-tutorial', :text => "1")
      page.should have_field('1-2-tutorial', :text => "1")
      page.should have_field('1-3-tutorial', :text => "1")
      page.should have_field('1-4-tutorial', :text => "1")
    end
  end

  scenario "Page interaction works correctly", :js => true do
    visit years_page
    click_link("2011")
    click_link("Select Course Weeks")

    within(:css, "div#123-a") do
      # Ensure that single rows are hidden when asked to merge
      check('merge')
      find('.single-row.hidden')
      find('.merged-row')

      # Ensure that merged rows are hidden when asked not to merge
      uncheck('merge')
      find('.single-row')
      find('.merged-row.hidden')

      fill_in('1-1-abc123', :with => "2")
      find('.lecture-count', :text => "2")
      fill_in('1-2-abc123', :with => "2")
      find('.lecture-count', :text => "4")
      fill_in('1-3-abc123', :with => "2")
      find('.lecture-count', :text => "6")
      fill_in('1-4-abc123', :with => "2")
      find('.lecture-count', :text => "8")

      click_link("1-zyx987-defaults")
      find('.lecture-count', :text => "14")
      find('.tutorial-count', :text => "3")
      find('.total', :text => "17")

      check('merge')
      find('.lecture-count', :text => "0")
      find('.total', :text => "3")
      uncheck('merge')
      find('.lecture-count', :text => "14")
      find('.total', :text => "17")

      fill_in('2-1-tutorial', :with => "1")
      find('.tutorial-count', :text => "4")
      fill_in('2-2-tutorial', :with => "1")
      find('.tutorial-count', :text => "5")
      fill_in('2-3-tutorial', :with => "1")
      find('.tutorial-count', :text => "6")
      fill_in('2-4-tutorial', :with => "1")
      find('.tutorial-count', :text => "7")

      fill_in('2-1-lab', :with => "1")
      find('.lab-count', :text => "1")
      fill_in('2-2-lab', :with => "1")
      find('.lab-count', :text => "2")
      fill_in('2-3-lab', :with => "1")
      find('.lab-count', :text => "3")
      fill_in('2-4-lab', :with => "1")
      find('.lab-count', :text => "4")

      find('.total', :text => "25")
    end
  end
end
