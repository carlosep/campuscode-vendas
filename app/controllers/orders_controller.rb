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
    set_collections
  end

  def create
    @order = current_user.orders.create(order_params)
    set_collections
    respond_with @order
  end

  def edit
    update_not_saving(params[:order]) if params[:order]
    set_collections
  end

  def update
    @order.update(order_params)
    set_collections
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
    @customers = Customer.all
    @products = Product.all
    if @order && @order.product_id
      @plans = Product.find(@order.product_id).plans
        if @order.plan_id
          @plan = Plan.find(@order.plan_id)
          @periodicities = Price.find(:all, from: @plan.prices_path)
          if @order.periodicity_id
            @periodicity = @periodicities.select{ |periodicity| periodicity.id == @order.periodicity_id}.first
            @price = @periodicity.value
          end
        end
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order)
          .permit(:status, :product_id, :customer_id, :user_id, :periodicity_id,
                  :price, :coupon, :plan_id)
  end

  def update_not_saving(params_order)
    @order.product_id = params_order[:product_id]
    @order.plan_id = params_order[:plan_id]
    @order.customer_id = params_order[:customer_id]
    @order.status = params_order[:status]
    @order.price = params_order[:price]
    @order.coupon = params_order[:coupon]
    @order.periodicity_id = params_order[:periodicity_id]
  end
end
