require 'rails_helper'

feature 'User searchs customer' do
  scenario 'By CPF and Succefully' do
    login
    customer = create(:customer)

    visit customers_path

    fill_in 'Buscar Cliente', with: '81239932006'

    click_on 'Buscar'

    expect(current_path).to eq customer_path(customer)
    expect(page).to have_content customer.name
    expect(page).to have_content customer.cpf_cnpj
    expect(page).to have_content customer.address
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.email
  end

  scenario 'By CNPJ and Succefully' do
    login
    customer = create(:customer, cpf_cnpj: '86584402000104',
                                 company_name: 'Campus code',
                                 contact_name: 'Alan Djah')

    visit customers_path

    fill_in 'Buscar Cliente', with: '86584402000104'

    click_on 'Buscar'

    expect(current_path).to eq customer_path(customer)
    expect(page).to have_content customer.name
    expect(page).to have_content customer.cpf_cnpj
    expect(page).to have_content customer.address
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.email
  end

  scenario 'failure' do
    login

    visit customers_path

    fill_in 'Buscar Cliente', with: 'aaaaaa'

    click_on 'Buscar'

    expect(page).to have_content 'Customer not found'
  end
end
