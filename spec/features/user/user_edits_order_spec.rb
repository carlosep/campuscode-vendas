require 'rails_helper'

describe 'User edits order' do
  scenario 'successfully' do
    user = create(:user, is_admin: true)
    customer = create(:customer, name: 'Carlos')
    order = create(:order)
    other_order = build(:order, status: 'Concluído', customer: customer)

    login(user)
    visit edit_order_path(order)

    fill_in "Product", with: 'Other product'
    select order.customer.name, from: "Customer"
    select order.status, from: "Status"

    click_on "Update Order"

    expect(page).to have_content 'Other product'
    expect(page).to have_content "Pedido #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content other_order.status
    expect(page).to have_content other_order.customer.name
    expect(page).to have_content order.user.name
  end
end
