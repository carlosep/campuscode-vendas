require 'rails_helper'

describe 'User edits order' do
  scenario 'successfully' do
    user = create(:user, is_admin: true)
    customer = create(:customer, name: 'Carlos',
                                 cpf_cnpj: '86584402000104',
                                 company_name: 'Campus code',
                                 contact_name: 'Alan Djah')
    order = create(:order)
    other_order = build(:order, status: 'Concluído',
                                customer: customer,
                                periodicity_id: 2)

    login(user)
    visit edit_order_path(order)

    select other_order.status, from: 'order[status]'
    select other_order.customer.name, from: 'order[customer_id]'
    select other_order.product.name, from: 'order[product_id]'
    select other_order.plan.name, from: 'order[plan_id]'
    select other_order.periodicity.name, from: 'order[periodicity_id]'

    click_on "Update Order"

    expect(page).to have_content "Order #{order.id}"
    expect(page).to have_content order.user.name
    expect(page).to have_content order.created_at.to_date
    expect(page).to have_content other_order.customer.name
    expect(page).to have_content other_order.status
    expect(page).to have_content other_order.plan.name
    expect(page).to have_content other_order.periodicity.name
    expect(page).to have_content '5.99'
  end
end
