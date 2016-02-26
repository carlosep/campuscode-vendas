require 'rails_helper'

describe 'Salesman registers a new customer without a contact name' do
  scenario 'successfully' do
    login

    customer = build(:customer)

    visit new_customer_path

    fill_in 'customer[name]',         with: customer.name
    fill_in 'customer[email]',        with: customer.email
    fill_in 'customer[phone]',        with: customer.phone
    fill_in 'customer[address]',        with: customer.address
    fill_in 'customer[cpf_cnpj]',        with: customer.cpf_cnpj

    click_on 'Create'

    expect(page).to have_content customer.name
    expect(page).to have_content customer.email
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.address
    expect(page).to have_content customer.cpf_cnpj
  end

  scenario 'and is mandatory to fill contact name when registers a company' do
    login

    customer = build(:customer, cpf_cnpj: '86584402000104')

    visit new_customer_path

    fill_in 'customer[name]',         with: customer.name
    fill_in 'customer[email]',        with: customer.email
    fill_in 'customer[phone]',        with: customer.phone
    fill_in 'customer[address]',        with: customer.address
    fill_in 'customer[cpf_cnpj]',        with: customer.cpf_cnpj

    click_on 'Create'

    expect(page).to have_css :span, 'Contact name can\'t be blank'
  end
end
