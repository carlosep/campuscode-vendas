require 'rails_helper'

describe 'User creates new order', :js => true do
  self.use_transactional_fixtures = false

  after(:each) do
    User.delete(User.all) if User.last
    Customer.delete(Customer.all) if Customer.last
    Order.delete(Order.all) if Order.last
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
    expect(page).to have_content order.price

  end

  scenario 'with coupon' do
    order = build(:order)

    login

    visit new_order_path

    select order.customer.name, from: 'order[customer_id]'
    select order.product.name, from: 'order[product_id]'
    select order.plan.name, from: 'order[plan_id]'
    select order.periodicity.name, from: "order[periodicity_id]"
    fill_in 'order[coupon]', with: 'MAQ7556'
    within ('section#order_form') do
      click_on 'Create'
    end

    expect(page).to have_content 'MAQ7556'
    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content order.product.name
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
    expect(page).to have_content order.periodicity.name
    expect(page).to have_content order.price
  end
end
