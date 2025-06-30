require 'rails_helper'

RSpec.describe 'User Login', type: :feature do
  let!(:user) { create(:user, password: "Password1!") }

  it 'logs in with correct credentials' do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'Password1!'
    click_button 'Login'

    expect(page).to have_content("Hi, #{user.email}")
    expect(current_path).to eq(shortened_urls_path)
  end

  it 'rejects wrong password' do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'wrong'
    click_button 'Login'

    expect(page).to have_content("Invalid email or password.")
  end

  it 'rejects non-existent user' do
    visit login_path
    fill_in 'email', with: "no_user@example.com"
    fill_in 'password', with: 'Password1!'
    click_button 'Login'

    expect(page).to have_content("Invalid email or password.")
  end

  it 'rejects empty fields' do
    visit login_path
    fill_in 'email', with: ''
    fill_in 'password', with: ''
    click_button 'Login'

    expect(page).to have_content("Invalid email or password.")
  end
end
