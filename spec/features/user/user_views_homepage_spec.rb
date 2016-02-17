require 'rails_helper'

describe 'User views Home Page' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content 'Vendas'
  end
end
