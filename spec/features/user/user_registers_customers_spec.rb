require 'rails_helper'

describe 'Salesman registers a new customer' do
  scenario 'successfully' do
    login
    customer = build(:customer)

    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: customer.email
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',  with: customer.contact_name

    click_on 'Create'

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

    click_on 'Create'

    %w(Name Email Phone Address).each do |attr_name|
      expect(page).to have_css :span, text: "#{attr_name} can't be blank",
                                      visible: true
    end
    expect(page).to have_css :span, text: 'CPF/CNPJ can\'t be blank',
                                    visible: true
  end

  scenario 'and failure when forget to fill Name fields' do
    login
    visit new_customer_path


    click_on 'Create'

    expect(page).to have_css :span, text: 'Name can\'t be blank',
                                    visible: true
  end

  scenario 'and failure when forget to fill Phone fields' do
    login
    visit new_customer_path


    click_on 'Create'

    expect(page).to have_css :span, text: 'Phone can\'t be blank',
                                    visible: true
  end

  scenario 'and failure when forget to fill Email fields' do
    login
    visit new_customer_path


    click_on 'Create'

    expect(page).to have_css :span, text: 'Email can\'t be blank',
                                    visible: true
  end

  scenario 'and failure when forget to fill Address fields' do
    login
    visit new_customer_path


    click_on 'Create'

    expect(page).to have_css :span, text: 'Address can\'t be blank',
                                    visible: true
  end

  scenario 'and failure when forget to fill cpf_cnpj fields' do
    login
    visit new_customer_path


    click_on 'Create'

    expect(page).to have_css :span, text: 'CPF/CNPJ can\'t be blank',
                                    visible: true
  end

  scenario 'Failure with invalid email' do
    login
    customer = build(:customer)


    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: 'a%2@'
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',  with: customer.contact_name

    click_on 'Create'

    expect(page).to_not have_content 'a%2@'
    expect(page).to have_css :span, text: 'Email is invalid',
                                    visible: true
  end

  scenario 'Failure when fill with invalid cpf' do
    customer = build(:customer)
    login

    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: customer.email
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: '11111111111'
    fill_in 'customer[contact_name]',  with: customer.contact_name

    click_on 'Create'

    expect(page).to_not have_content '11111111111'
    expect(page).to have_css :span, text: 'CPF/CNPJ is invalid',
                                    visible: true
  end

  scenario 'Failure when fill with invalid cnpj' do
    customer = build(:customer)
    login

    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: customer.email
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: '12345678901234'
    fill_in 'customer[contact_name]',  with: customer.contact_name

    click_on 'Create'

    expect(page).to_not have_content '12345678901234'
    expect(page).to have_css :span, text: 'CPF/CNPJ is invalid',
                                    visible: true
  end

  scenario 'and sends confirmation mail' do
    sent_count = ActionMailer::Base.deliveries.count
    login
    customer = build(:customer)

    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: customer.email
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',  with: customer.contact_name

    click_on 'Create'

    expect(ActionMailer::Base.deliveries.count).to eq sent_count + 1
  end

  scenario 'And failure when already has registered cpf' do
    customer = create(:customer)

    login

    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: customer.email
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',  with: customer.contact_name
    click_on 'Create'

    expect(page).to have_css :span, text: 'CPF/CNPJ has already been taken',
                                    visible: true
  end

  scenario 'And failure when already has registered cnpj' do
    customer = create(:customer, cpf_cnpj: '86584402000104',
                                 razao_social: 'Campus code',
                                 contact_name: 'Alan Djah')

    login

    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: customer.email
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',  with: customer.contact_name
    click_on 'Create'

    expect(page).to have_css :span, text: 'CPF/CNPJ has already been taken',
                                    visible: true
  end

  scenario 'And failure when already has registered email' do
    customer = create(:customer)

    login

    visit new_customer_path

    fill_in 'customer[name]',          with: customer.name
    fill_in 'customer[email]',         with: customer.email
    fill_in 'customer[phone]',         with: customer.phone
    fill_in 'customer[address]',       with: customer.address
    fill_in 'customer[cpf_cnpj]',      with: customer.cpf_cnpj
    fill_in 'customer[contact_name]',  with: customer.contact_name
    click_on 'Create'

    expect(page).to have_css :span, text: 'Email has already been taken',
                                    visible: true
  end
end
