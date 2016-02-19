require 'rails_helper'

describe 'Salesman registers a new customer without a contact name' do
  scenario 'successfully' do
    login

    custumer = create(:customer)

    visit new_customer_path

    fill_in Customer.human_attribute_name(:name),         with: customer.name
    fill_in Customer.human_attribute_name(:email),        with: customer.email
    fill_in Customer.human_attribute_name(:phone),        with: customer.phone
    fill_in Customer.human_attribute_name(:address),      with: customer.address
    fill_in Customer.human_attribute_name(:cpf_cnpj),
    with: customer.cpf_cnpj

    click_on 'Save'

    expect(page).to have_content customer.name
    expect(page).to have_content customer.email
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.address
    expect(page).to have_content customer.cpf_cnpj
  end

  scenario 'and is mandatory to fill contact name when registers a company' do
    login

    customer = create(:customer, cpf_cnpj: '86584402000104')

    visit new_customer_path

    fill_in Customer.human_attribute_name(:name),         with: customer.name
    fill_in Customer.human_attribute_name(:email),        with: customer.email
    fill_in Customer.human_attribute_name(:phone),        with: customer.phone
    fill_in Customer.human_attribute_name(:address),      with: customer.address
    fill_in Customer.human_attribute_name(:cpf_cnpj),
    with: customer.cpf_cnpj

    click_on 'Save'

    expect(page).to have_css :span, 'Contact name can\'t be blank'
  end
end
