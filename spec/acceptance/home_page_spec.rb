require 'acceptance/acceptance_helper'

feature "Home Page", %q{
  In order ...
  As ...
  I want to ...
} do

  scenario "I can access the rooms page" do
    visit home_page
    page.should have_link("Rooms")
    click_link("Rooms")
    current_path.should == rooms_page
  end

  scenario "I can access the years page" do
    visit home_page
    page.should have_link("Years")
    click_link("Years")
    current_path.should == years_page
  end
end
