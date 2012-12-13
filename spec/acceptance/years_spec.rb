require 'acceptance/acceptance_helper'

feature "Years", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @year1 = FactoryGirl.create(:year, :no => 2011)
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
end
