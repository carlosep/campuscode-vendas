class OrdersController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit]
  before_action :set_order, only: [:show, :edit, :update, :order_status]
  before_action :user_admin, only: [:edit, :update]
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

  def order_status
   type = params[:type]
   if type == 'finish'
    @order.status = 'Concluído'
     redirect_to :back, notice: "Você concluiu o pedido #{@order.id}"
   elsif type == 'cancel'
    @order.status = 'Cancelado'
     redirect_to :back, notice: "Você cancelou o pedido #{@order.id}"
   else
     redirect_to :back, notice: 'Nothing happened.'
   end
   @order.save
 end

  private

  def set_collections
    @customer = Customer.all
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order)
          .permit(:status, :product, :customer_id, :user_id)
  end
end
