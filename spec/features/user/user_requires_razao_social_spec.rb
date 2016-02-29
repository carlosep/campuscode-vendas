require 'rails_helper'

describe 'Salesman registers a new customer with cnpj' do
  scenario 'successfully' do
    login

    customer = build(:customer, cpf_cnpj: '86584402000104',
                                company_name: 'Campus code',
                                contact_name: 'Alan Djah' )

    visit new_customer_path

    fill_in 'customer[name]',             with: customer.name
    fill_in 'customer[email]',            with: customer.email
    fill_in 'customer[phone]',            with: customer.phone
    fill_in 'customer[address]',          with: customer.address
    fill_in 'customer[cpf_cnpj]',         with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',     with: customer.contact_name
    fill_in 'customer[company_name]',     with: customer.company_name

    select '1995',   from: 'customer[birth_date(1i)]'
    select 'Março',  from: 'customer[birth_date(2i)]'
    select '16',     from: 'customer[birth_date(3i)]'

    click_on 'Criar'

    expect(page).to have_content customer.name
    expect(page).to have_content customer.email
    expect(page).to have_content customer.phone
    expect(page).to have_content customer.address
    expect(page).to have_content customer.cpf_cnpj
    expect(page).to have_content customer.company_name
    expect(page).to have_content customer.contact_name
  end

  scenario 'and is mandatory to fill Company name when registers a company' do
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

    click_on 'Criar'

    expect(page).to have_css :span, text: 'Nome da Empresa não pode ser branco',
                                    visible: true
  end
end
