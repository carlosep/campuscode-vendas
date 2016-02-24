require 'rails_helper'

describe 'User creates new order' do
  scenario 'successfully' do
    order = build(:order)

    login
    visit new_order_path

    select order.product.name, from: 'Product'
    select order.customer.name, from: "Customer"
    select order.periodicity.name, from: "Periodicity"

    within ('section#order_form') do
      click_on 'Create Order'
    end

    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content 'Hospedagem'
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
  end

  scenario 'with coupon' do
    order = build(:order)

    login

    visit new_order_path

    select order.product.name, from: 'Product'
    select order.customer.name, from: "Customer"
    select order.periodicity.name, from: "Periodicity"
    fill_in 'order[coupon]', with: 'MAQ7556'
    within ('section#order_form') do
      click_on 'Create Order'
    end

    expect(page).to have_content 'MAQ7556'
    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content order.product.name
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
  end
end
