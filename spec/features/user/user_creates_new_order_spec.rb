require 'rails_helper'

describe 'User creates new order', :js => true do
  self.use_transactional_fixtures = false
  scenario 'successfully' do
    User.last.delete if User.last
    Customer.last.delete if Customer.last
    Order.last.delete if Order.last
    user = create(:user, email: 'a@gmail.com', password: '12345678')
    customer = create(:customer, email: 'a@gmail.com')
    order = build(:order, user: user, customer: customer)

    visit root_path

    fill_in 'user[email]',    with: 'a@gmail.com'
    fill_in 'user[password]', with: '12345678'

    click_on 'Log in'

    visit new_order_path

    select 'Hospedagem', from: 'order[product_id]'
    select 'Profissional', from: 'Plan'
    select order.customer.name, from: "Customer"

    within ('section#order_form') do
      click_on 'Create Order'
    end

    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content 'Hospedagem'
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name

    User.last.delete
    Customer.last.delete
    Order.last.delete
  end

  scenario 'with coupon' do
    order = build(:order)

    login

    visit new_order_path

    select 'Hospedagem', from: 'Product'
    select order.customer.name, from: "Customer"
    fill_in 'order[coupon]', with: 'MAQ7556'
    within ('section#order_form') do
      click_on 'Create Order'
    end

    expect(page).to have_content 'MAQ7556'
    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content 'Hospedagem'
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
  end
end
