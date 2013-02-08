require 'acceptance/acceptance_helper'

feature "Clashes", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @year = FactoryGirl.create(:year, :no => 2011)
  end

  scenario "Can access the clashes selection page" do
    visit years_page
    page.should have_content("2011")
    click_link("2011")

    current_path.should == year_page(@year)

    page.should have_link("Select Clashes")
    click_link("Select Clashes")
  end
end
