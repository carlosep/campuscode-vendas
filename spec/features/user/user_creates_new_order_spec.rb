require 'rails_helper'

describe 'User creates new order', :js => true do
  scenario 'successfully' do
    order = build(:order)
    
    visit new_order_path

    select 'Hospedagem', from: 'order[product_id]'
    select 'Profissional', from: 'Plan'
    select order.customer.name, from: "Customer"

    within ('section#order_form') do
      click_on "Create Order"
    end

    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.created_at
    expect(page).to have_content order.status
    expect(page).to have_content 'Hospedagem'
    expect(page).to have_content order.customer.name
    expect(page).to have_content order.user.name
  end
end
