require 'rails_helper'

describe 'User views his profile' do
  scenario 'successfully' do
    user = create :user
    login user

    click_on 'Meus dados'

    expect(page).to have_content user.name
  end
end
