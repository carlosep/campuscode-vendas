require 'rails_helper'

describe 'User views Home Page' do
  scenario 'successfully' do
    login

    expect(page).to have_content 'Vendas'
  end
end
