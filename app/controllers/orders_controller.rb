class OrdersController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit]
  before_action :set_order, only: [:show, :edit, :update, :order_status]
  before_action :user_admin, only: [:edit, :update]

  def show
  end

  def new
    @order = params[:order] ? Order.new(order_params) : Order.new
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
    @products = Product.all
    @periodicities = Periodicity.all
    if params[:order].try(:[], :product_id).try(:present?)
      @plans = Product.find(params[:order][:product_id]).plans
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order)
          .permit(:status, :product_id, :customer_id, :user_id, :periodicity_id,
                  :price_id, :coupon, :plan_id)
  end
end
