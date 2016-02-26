class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :order_status]
  before_action :set_collections, only: [:new, :create, :edit, :update]
  before_action :user_admin, only: [:edit, :update, :index]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = params[:order] ? Order.new(order_params) : Order.new
    set_plans
  end

  def create
    @order = current_user.orders.create(order_params)
    set_plans
    respond_with @order
  end

  def edit
    update_not_saving(params[:order]) if params[:order]
    set_plans
  end

  def update
    @order.update(order_params)
    set_plans
    respond_with @order
  end

  def order_status
    type = params[:type]
    if type == 'finish'
      @order.status = 'Concluído'
      CustomerMailer.conclusion_email(@order).deliver_now
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
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_plans
    if @order && @order.product_id
      @plans = Product.find(@order.product_id).plans
    end
  end

  def order_params
    params.require(:order)
          .permit(:status, :product_id, :customer_id, :user_id, :periodicity_id,
                  :price_id, :coupon, :plan_id)
  end

  def update_not_saving(params_order)
    @order.product_id = params_order[:product_id]
    @order.plan_id = params_order[:plan_id]
    @order.customer_id = params_order[:customer_id]
    @order.status = params_order[:status]
    @order.price_id = params_order[:price_id]
    @order.coupon = params_order[:coupon]
    @order.periodicity_id = params_order[:periodicity_id]
  end
end
