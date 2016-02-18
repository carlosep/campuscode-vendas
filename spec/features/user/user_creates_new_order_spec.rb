require 'rails_helper'
# Adicionar User No futuro. na view tbm, motherfucker.
describe 'User creates new order' do
  scenario 'successfully' do
    order = build(:order)

    visit new_order_path

    fill_in "Product", with: order.product
    select order.customer.name, from: "Customer"
    select order.status, from: "Status"

    click_on "Create Order"

    expect(page).to have_content "Pedido #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content order.product
    expect(page).to have_content order.customer.name
  end
end
