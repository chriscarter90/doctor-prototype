require 'acceptance/acceptance_helper'

feature "Home Page", %q{
  In order ...
  As ...
  I want to ...
} do

  scenario "I can access the years page" do
    visit home_page
    page.should have_link("Years")
    click_link("Years")
    current_path.should == years_page
  end
end
