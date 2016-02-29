require 'rails_helper'

feature 'Salesman edits customer' do
  scenario 'Successfully' do
    customer = create(:customer)
    login
    new_customer = build(:customer, name: 'Gabriel', phone: '11 989314294',
                         address: 'Diadema', contact_name: 'Gabriel',
                         email: 'gabriel@gmail.com', cpf_cnpj: '36476847163')

    visit edit_customer_path(customer)

    fill_in 'customer[name]',         with: new_customer.name
    fill_in 'customer[phone]',        with: new_customer.phone
    fill_in 'customer[address]',      with: new_customer.address
    fill_in 'customer[email]',        with: new_customer.email
    fill_in 'customer[contact_name]', with: new_customer.contact_name
    fill_in 'customer[cpf_cnpj]',     with: new_customer.cpf_cnpj
    select '1995',   from: 'customer[birth_date(1i)]'
    select 'Março',  from: 'customer[birth_date(2i)]'
    select '16',     from: 'customer[birth_date(3i)]'

    within ('section#customer_form') do
      click_on 'Atualizar'
    end

    expect(page).to have_content new_customer.name
    expect(page).to have_content new_customer.phone
    expect(page).to have_content new_customer.email
    expect(page).to have_content new_customer.contact_name
    expect(page).to have_content new_customer.address
    expect(page).to have_content new_customer.cpf_cnpj
    expect(page).to have_content new_customer.birth_date
  end
end
