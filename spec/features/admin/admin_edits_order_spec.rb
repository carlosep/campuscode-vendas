require 'rails_helper'

describe 'Admin edits order', js: true do
  self.use_transactional_fixtures = false

  after(:each) do
    User.delete(User.all) if User.last
    Customer.delete(Customer.all) if Customer.last
    Order.delete(Order.all) if Order.last
  end

  scenario 'successfully' do
    user = create(:user, is_admin: true)
    customer = create(:customer, name: 'Carlos',
                                 cpf_cnpj: '86584402000104',
                                 company_name: 'Campus code',
                                 contact_name: 'Alan Djah')
    order = create(:order)
    other_order = build(:order, status: 'Concluído',
                                customer: customer,
                                periodicity_id: 2,
                                user: order.user)

    login(user)
    visit edit_order_path(order)

    select other_order.status, from: 'order[status]'
    select other_order.customer.name, from: 'order[customer_id]'
    select other_order.product.name, from: 'order[product_id]'
    select other_order.plan.name, from: 'order[plan_id]'
    select other_order.periodicity.name, from: 'order[periodicity_id]'

    click_on 'Atualizar'

    expect(page).to have_content "Pedido #{order.id}"
    expect(page).to have_content order.user.name
    expect(page).to have_content order.created_at.to_date
    expect(page).to have_content other_order.customer.name
    expect(page).to have_content other_order.status
    expect(page).to have_content other_order.plan.name
    expect(page).to have_content other_order.periodicity.name
    expect(page).to have_content other_order.price
  end
end
