require 'rails_helper'

describe 'User edits order status' do
  scenario 'successfully finishes it' do
    user = create(:user)
    order = create(:order)

    login(user)
    visit order_path(order)

    click_on "Concluir Pedido"

    expect(page).to have_content "Você concluiu o pedido #{order.id}"
    expect(page).to have_content 'Concluído'
  end

  scenario 'successfully cancels it' do
    user = create(:user)
    order = create(:order)

    login(user)
    visit order_path(order)

    click_on "Cancelar Pedido"

    expect(page).to have_content "Você cancelou o pedido #{order.id}"
    expect(page).to have_content 'Cancelado'
  end

  scenario 'fails when order is canceled' do
    user = create(:user)
    order = create(:order, status: 'Cancelado')

    login(user)
    visit order_path(order)

    expect(page).not_to have_link 'Cancelar Pedido'
    expect(page).not_to have_link 'Concluir Pedido'
  end

  scenario 'fails when order is finished' do
    user = create(:user)
    order = create(:order, status: 'Concluído')

    login(user)
    visit order_path(order)

    expect(page).not_to have_link 'Concluir Pedido'
    expect(page).not_to have_link 'Cancelar Pedido'
  end
end
