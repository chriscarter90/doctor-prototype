require 'acceptance/acceptance_helper'

feature "Rooms", %q{
  In order ...
  As ...
  I want to ...
} do

  before :each do
    @room1 = FactoryGirl.create(:room, :no => 308, :capacity => 200)
    @room2 = FactoryGirl.create(:room, :no => 311, :capacity => 180)
  end

  scenario "Can see the rooms on the page" do
    visit rooms_page
    page.should have_content("308")
    page.should have_content("200")
    page.should have_content("308")
    page.should have_content("180")
  end
end
