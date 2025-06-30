require 'rails_helper'

RSpec.describe 'Admin Panel Access', type: :feature do
  let!(:admin) { create(:user, role: :admin, password: "Password1!") }
  let!(:user) { create(:user, role: :user, password: "Password1!") }

  it 'admin can access admin panel' do
    visit login_path
    fill_in 'email', with: admin.email
    fill_in 'password', with: 'Password1!'
    click_button 'Login'

    expect(page).to have_link('Admin Panel')
    click_link 'Admin Panel'
    expect(current_path).to eq(admin_users_path)
  end

  it 'user cannot access admin panel' do
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'Password1!'
    click_button 'Login'

    visit admin_users_path
    expect(page).to have_content("Access denied!")
    expect(current_path).to eq(shortened_urls_path)
  end

  it 'unauthenticated user is redirected from admin panel' do
    visit admin_users_path
    expect(current_path).to eq(login_path)
  end
end
