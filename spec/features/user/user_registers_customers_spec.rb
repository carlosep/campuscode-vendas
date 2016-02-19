require 'rails_helper'

describe 'Salesman registers a new customer' do
  scenario 'successfully' do
    login
    customer = create(:customer)

    visit new_customer_path

    fill_in Customer.human_attribute_name(:name),         with: customer.name
    fill_in Customer.human_attribute_name(:email),        with: customer.email
    fill_in Customer.human_attribute_name(:phone),        with: customer.phone
    fill_in Customer.human_attribute_name(:address),      with: customer.address
    fill_in Customer.human_attribute_name(:cpf_cnpj),
    with: customer.cpf_cnpj
    fill_in Customer.human_attribute_name(:contact_name),
    with: customer.contact_name

    click_on 'Save'

    expect(page).to have_content customer.name
    expect(page).to have_content customer.email
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.address
    expect(page).to have_content customer.cpf_cnpj
    expect(page).to have_content customer.contact_name
  end

  scenario 'and failure when forget to fill some fields' do
    login
    visit new_customer_path


    click_on 'Save'

    %w(Name Email Phone Address cpf_cnpj contact_name).each do |attr_name|
      expect(page).to have_css :span, "#{attr_name} can't be blank"
    end
  end

  scenario 'and failure when forget to fill Name fields' do
    login
    visit new_customer_path


    click_on 'Save'

    expect(page).to have_css :span, 'Name can\'t be blank'
  end

  scenario 'and failure when forget to fill Phone fields' do
    login
    visit new_customer_path


    click_on 'Save'

    expect(page).to have_css :span, 'Phone can\'t be blank'
  end

  scenario 'and failure when forget to fill Email fields' do
    login
    visit new_customer_path


    click_on 'Save'

    expect(page).to have_css :span, 'Email can\'t be blank'
  end

  scenario 'and failure when forget to fill Address fields' do
    login
    visit new_customer_path


    click_on 'Save'

    expect(page).to have_css :span, 'Address can\'t be blank'
  end

  scenario 'and failure when forget to fill cpf_cnpj fields' do
    login
    visit new_customer_path


    click_on 'Save'

    expect(page).to have_css :span, 'Cpf cnpj can\'t be blank'
  end

  scenario 'and failure when forget to fill contact_name fields' do
    login
    visit new_customer_path


    click_on 'Save'

    expect(page).to have_css :span, 'Contact name can\'t be blank'
  end

  scenario 'Failure with invalid email' do
    login
    customer = create(:customer)


    visit new_customer_path

    fill_in Customer.human_attribute_name(:name),         with: customer.name
    fill_in Customer.human_attribute_name(:email),        with: 'a%2@'
    fill_in Customer.human_attribute_name(:phone),        with: customer.phone
    fill_in Customer.human_attribute_name(:address),      with: customer.address
    fill_in Customer.human_attribute_name(:cpf_cnpj),
    with: customer.cpf_cnpj
    fill_in Customer.human_attribute_name(:contact_name),
    with: customer.contact_name

    click_on 'Save'

    expect(page).to_not have_content 'a%2@'
    expect(page).to have_css :span, 'Email is invalid'
  end

  scenario 'Failure when fill with invalid cpf' do
    customer = create(:customer)
    login

    visit new_customer_path

    fill_in Customer.human_attribute_name(:name),         with: customer.name
    fill_in Customer.human_attribute_name(:email),        with: customer.email
    fill_in Customer.human_attribute_name(:phone),        with: customer.phone
    fill_in Customer.human_attribute_name(:address),      with: customer.address
    fill_in Customer.human_attribute_name(:cpf_cnpj),
    with: '11111111111'
    fill_in Customer.human_attribute_name(:contact_name),
    with: customer.contact_name

    click_on 'Save'

    expect(page).to_not have_content '11111111111'
    expect(page).to have_css :span, 'Cpf cnpj is invalid'
    expect(current_path).to_not eq(customers_path(customer))
  end

  scenario 'Failure when fill with invalid cnpj' do
    customer = create(:customer)
    login

    visit new_customer_path

    fill_in Customer.human_attribute_name(:name),         with: customer.name
    fill_in Customer.human_attribute_name(:email),        with: customer.email
    fill_in Customer.human_attribute_name(:phone),        with: customer.phone
    fill_in Customer.human_attribute_name(:address),      with: customer.address
    fill_in Customer.human_attribute_name(:cpf_cnpj),
    with: '12345678901234'
    fill_in Customer.human_attribute_name(:contact_name),
    with: customer.contact_name

    click_on 'Save'

    expect(page).to_not have_content '12345678901234'
    expect(page).to have_css :span, 'Cpf cnpj is invalid'
    expect(current_path).to_not eq(customers_path(customer))
  end
end
