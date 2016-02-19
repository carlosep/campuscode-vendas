class OrdersController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit]
  before_action :set_order, only: [:show, :edit, :update]
  before_action :user_admin, only: [:edit, :update]
  before_action :set_status, only: [:create]
  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.create(order_params)
    respond_with @order
  end

  def edit
  end

  def update
    @order.update(order_params)
    respond_with @order
  end

  private

  def set_collections
    @customer = Customer.all
  end

  def set_status
    params[:order][:status] = 'Aberto'
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order)
          .permit(:status, :product, :customer_id, :user_id)
  end
end
