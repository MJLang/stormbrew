require 'rails_helper'


feature 'A User tries to login', js: true do
  let(:user) { FactoryGirl.create(:user)}

  scenario 'with valid information' do
    visit '/'
    click_link 'Login', match: :first
    within "#loginTab" do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: 'secret'
      click_button 'Login'
    end

    wait_for_ajax

    within '#topbar' do
      expect(page).to have_content("Hello #{user.display_name}")
      expect(page).to_not have_content("Login")
    end
  end


end
