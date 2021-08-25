require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create!(email: 'cindy@mail.com', first_name: 'cindy', last_name: 'White', password: '123456')
  end

  scenario "after user login" do

    # need to use html attributes to target the elements
    visit root_path
    find('a', text: "Login").click
    fill_in 'Email:', with: 'cindy@mail.com'
    fill_in 'Password:', with: '123456'  
    click_on "Submit"
    
    # commented out b/c it's for debugging only
    save_and_open_screenshot

    # need to use class name in the html to track the element
     expect(page).to have_content( 'Signed in as cindy' )

    
  end



end
