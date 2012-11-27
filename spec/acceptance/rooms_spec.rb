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

  scenario "Can edit one of the rooms" do
    visit rooms_page
    page.should have_link("Edit")
    click_link("Edit")

    current_path.should == edit_room_page(@room1)

    fill_in("Capacity", :with => 150)
    click_button("Update")

    current_path.should == rooms_page
    page.should have_content("Room was successfully updated.")
    page.should have_content("150")
    page.should_not have_content("200")

    click_link("Edit")

    fill_in("Capacity", :with => "")
    click_button("Update")

    page.should have_content("Room could not be updated.")
  end
end
