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

  scenario "Can see the rooms on the page" do
    visit years_page
    page.should have_content("2011")
    page.should have_content("2012")
  end
end
