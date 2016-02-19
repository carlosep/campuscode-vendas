require 'rails_helper'

describe 'Admin creates a new admin' do
  scenario 'successfully' do
    user = build(:user)
    admin = create(:user, is_admin: true)

    login admin
    visit new_user_path

    fill_in 'user[name]', with: user.name
    fill_in 'user[email]', with: user.email
    check 'user[is_admin]'

    click_on I18n.t('users.new.create_user_button')

    expect(page).to have_content user.name
    expect(page).to have_content user.email
  end

  scenario 'unsuccessfully' do
    user = build(:user)

    login
    visit new_user_path

    expect(page).to have_content 'Você não é o administrador'
    expect(current_path).to eq root_path
  end
end
