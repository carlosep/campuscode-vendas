require 'rails_helper'
describe 'User creates new order' do
  scenario 'successfully' do
    order = build(:order)

    login
    visit new_order_path

    fill_in "Product", with: order.product
    select order.customer.name, from: "Customer"

    within ('section#order_form') do
      click_on "Create Order"
    end

    expect(page).to have_content "Pedido #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content order.product
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
  end
  scenario 'with default status and customer' do
    order = build(:order)

    login
    visit new_order_path

    fill_in "Product", with: order.product

    within ('section#order_form') do
      click_on "Create Order"
    end

    expect(page).to have_content "Pedido #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content order.product
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
  end
end
