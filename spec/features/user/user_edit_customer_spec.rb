require 'rails_helper'

feature 'Salesman edits customer' do
  scenario 'Successfully' do
    customer = create(:customer)
    login
    new_customer = build(:customer, name: 'Gabriel', phone: '11 989314294',
                         address: 'Diadema', contact_name: 'Gabriel',
                         email: 'gabriel@gmail.com', cpf_cnpj: '36476847163')

    visit edit_customer_path(customer)

    fill_in 'Name',         with: new_customer.name
    fill_in 'Phone',        with: new_customer.phone
    fill_in 'Address',      with: new_customer.address
    fill_in 'Email',        with: new_customer.email
    fill_in 'Contact name', with: new_customer.contact_name
    fill_in 'Cpf cnpj',     with: new_customer.cpf_cnpj

    click_on 'Update'

    expect(page).to have_content new_customer.name
    expect(page).to have_content new_customer.phone
    expect(page).to have_content new_customer.email
    expect(page).to have_content new_customer.contact_name
    expect(page).to have_content new_customer.address
    expect(page).to have_content new_customer.cpf_cnpj
  end
end
