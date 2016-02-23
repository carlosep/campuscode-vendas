require 'rails_helper'

describe 'Salesman registers a new customer with cnpj' do
  scenario 'successfully' do
    login

    customer = build(:customer, cpf_cnpj: '86584402000104',
                                razao_social: 'Campus code',
                                contact_name: 'Alan Djah' )

    visit new_customer_path

    fill_in 'customer[name]',             with: customer.name
    fill_in 'customer[email]',            with: customer.email
    fill_in 'customer[phone]',            with: customer.phone
    fill_in 'customer[address]',          with: customer.address
    fill_in 'customer[cpf_cnpj]',         with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',     with: customer.contact_name
    fill_in 'customer[razao_social]',     with: customer.razao_social

    select '1995',   from: 'customer[birth_date(1i)]'
    select 'March',  from: 'customer[birth_date(2i)]'
    select '16',     from: 'customer[birth_date(3i)]'

    click_on 'Create'

    expect(page).to have_content customer.name
    expect(page).to have_content customer.email
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.address
    expect(page).to have_content customer.cpf_cnpj
    expect(page).to have_content customer.razao_social
    expect(page).to have_content customer.contact_name
  end

  scenario 'and is mandatory to fill razao social when registers a company' do
    login

    customer = build(:customer, cpf_cnpj: '86584402000104',
                                contact_name: 'Alan Djah')

    visit new_customer_path

    fill_in 'customer[name]',             with: customer.name
    fill_in 'customer[email]',            with: customer.email
    fill_in 'customer[phone]',            with: customer.phone
    fill_in 'customer[address]',          with: customer.address
    fill_in 'customer[cpf_cnpj]',         with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',     with: customer.contact_name
    click_on 'Create'

    expect(page).to have_css :span, text: 'Razao social can\'t be blank',
                                    visible: true
  end
end
