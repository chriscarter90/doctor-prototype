require 'acceptance/acceptance_helper'

feature "Years", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @year1 = FactoryGirl.build(:year, :no => 2011)
    @year1.terms = [
                     FactoryGirl.create(:term, :no => 1, :no_weeks => 4, :start_date => Date.parse("01/10/2011"), :year => @year1),
                     FactoryGirl.create(:term, :no => 2, :no_weeks => 6, :start_date => Date.parse("05/01/2012"), :year => @year1),
                     FactoryGirl.create(:term, :no => 3, :no_weeks => 5, :start_date => Date.parse("25/04/2012"), :year => @year1)
                   ]
    @year1.save!
    @year2 = FactoryGirl.create(:year, :no => 2012)
  end

  scenario "Can see the years on the page" do
    visit years_page
    page.should have_content("2011")
    page.should have_content("2012")
  end

  scenario "Can create a new year" do
    visit years_page
    page.should have_link("Create Year")
    click_link("Create Year")

    current_path.should == new_year_page

    fill_in("No", :with => "2013")
    fill_in("year_terms_attributes_0_no_weeks", :with => "3")
    fill_in("year_terms_attributes_0_start_date", :with => "01/10/2013")
    fill_in("year_terms_attributes_1_no_weeks", :with => "5")
    fill_in("year_terms_attributes_1_start_date", :with => "05/01/2014")
    fill_in("year_terms_attributes_2_no_weeks", :with => "6")
    fill_in("year_terms_attributes_2_start_date", :with => "25/04/2014")

    click_button("Create Year")

    current_path.should == years_page

    page.should have_content("Year was created successfully.")
    page.should have_content("2013")

    Year.last.terms.in_order.map(&:weeks).map(&:size).should == [3, 5, 6]
  end

  scenario "Can edit a year" do
    visit years_page
    page.should have_link("2011")
    click_link("2011")

    current_path.should == year_page(@year1)

    page.should have_content("2011")
    page.should have_content("Term 1: 4 weeks starting 1 October 2011")
    page.should have_content("Term 2: 6 weeks starting 5 January 2012")
    page.should have_content("Term 3: 5 weeks starting 25 April 2012")

    page.should have_link("Edit")
    click_link("Edit")

    page.should have_field(:no)

    fill_in("year_terms_attributes_0_no_weeks", :with => "7")
    fill_in("year_terms_attributes_0_start_date", :with => "02/10/2011")

    click_button("Update Year")

    page.should have_content("Year was updated successfully.")

    page.should have_content("Term 1: 7 weeks starting 2 October 2011")
    page.should have_content("Term 2: 6 weeks starting 5 January 2012")
    page.should have_content("Term 3: 5 weeks starting 25 April 2012")
  end
end
