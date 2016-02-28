require 'rails_helper'

describe 'User creates new order', :js => true do
  self.use_transactional_fixtures = false

  after(:each) do
    User.last.delete if User.last
    Customer.last.delete if Customer.last
    Order.last.delete if Order.last
  end

  scenario 'successfully' do
    order = build(:order)

    login

    visit new_order_path

    select order.customer.name, from: 'order[customer_id]'
    select order.product.name, from: 'order[product_id]'
    select order.plan.name, from: 'order[plan_id]'
    select order.periodicity.name, from: "order[periodicity_id]"

    within ('section#order_form') do
      click_on 'Create'
    end

    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.status
    expect(page).to have_content order.created_at
    expect(page).to have_content order.plan.name
    expect(page).to have_content order.user.name
    expect(page).to have_content order.periodicity.name
    expect(page).to have_content '3.99'

  end

  scenario 'with coupon' do
    order = build(:order)

    login

    visit new_order_path

    select order.product.name, from: 'Product'
    select 'Profissional', from: 'Plan'
    select order.customer.name, from: 'Customer'
    select order.periodicity.name, from: 'Periodicity'

    fill_in 'order[coupon]', with: coupon.code

    within ('section#order_form') do
      click_on 'Create'
    end

    expect(page).to have_content coupon.code
    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content order.product.name
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
    expect(page).to have_content order.periodicity.name
    expect(page).to have_content '3.99'
  end

  scenario 'Failure with invalid coupon' do
    user = create(:user, email: 'a@gmail.com', password: '12345678')
    customer = create(:customer, email: 'a@gmail.com')
    order = build(:order, user: user, customer: customer)

    visit root_path

    fill_in 'user[email]',    with: 'a@gmail.com'
    fill_in 'user[password]', with: '12345678'

    click_on 'Log in'

    visit new_order_path

    select order.product.name,          from: 'Product'
    select 'Profissional',              from: 'Plan'
    select order.customer.name,         from: 'Customer'
    select order.periodicity.name,      from: 'Periodicity'
    fill_in 'order[coupon]',            with: 'BLABLA'

    within('section#order_form') do
      click_on 'Create'
    end

    expect(page).to have_css :span, text: 'Invalid coupon!', visible: true
  end
end
