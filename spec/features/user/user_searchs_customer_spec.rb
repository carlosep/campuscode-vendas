require 'rails_helper'

feature 'User searchs customer' do
  scenario 'By CPF and Succefully' do
    login
    customer = create(:customer)

    visit root_path

    fill_in 'Search customer', with: '81239932006'
    click_on 'Search'

    expect(current_path).to eq customer_path(customer)
    expect(page).to have_content customer.name
    expect(page).to have_content customer.cpf_cnpj
    expect(page).to have_content customer.address
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.email
  end

  scenario 'By CNPJ and Succefully' do
    login
    customer = create(:customer, cpf_cnpj: '86584402000104')

    visit root_path

    fill_in 'Search customer', with: '86584402000104'
    click_on 'Search'

    expect(current_path).to eq customer_path(customer)
    expect(page).to have_content customer.name
    expect(page).to have_content customer.cpf_cnpj
    expect(page).to have_content customer.address
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.email
  end
end
