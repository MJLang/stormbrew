require 'rails_helper'

feature 'A User tries to signup' do
  scenario 'with valid information', js: true do
    display_name = FFaker::Internet.user_name
    email = FFaker::Internet.email
    visit '/'
    click_link 'Register'
    within '#registerTab' do
      fill_in 'Display Name', with: display_name
      fill_in 'Email', with: email
      fill_in 'Password', with: FFaker::Internet.password
      click_button 'Register'
    end

    wait_for_ajax
    expect(User.count).to eq(1)
    user = User.first
    expect(user.email).to eq(email)
    expect(user.display_name).to eq(display_name)
    within "#topbar" do
      expect(page).to have_content("Hello #{display_name}")
    end

  end

  scenario 'with invalid information - Existing Email', js: true do
    existing_user = FactoryGirl.create(:user)

    visit '/'
    click_link 'Register'
    within '#registerTab' do
      fill_in 'Display Name', with: 'ABC'
      fill_in 'Email', with: existing_user.email
      fill_in 'Password', with: 'secret'
      click_button 'Register'
    end


    expect(User.count).to eq(1)
    within "#topbar" do
      expect(page).to have_content("Register")
    end
  end
end