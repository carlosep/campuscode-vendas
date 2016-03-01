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
    @order = current_user.orders.build(order_params)
    set_collections

    if order_params[:coupon].empty?
      @order.save
      respond_with @order
    else
      with_coupon
    end
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
    case params[:type]
    when 'finish'
      finish
    when 'cancel'
      cancel
    else
      redirect_to :back
    end
    @order.save
  end

  private

  def cancel
    @order.status = 'Cancelado'
    redirect_to :back, notice: "Você cancelou o pedido #{@order.id}"
  end

  def finish
    @order.status = 'Concluído'
    CustomerMailer.conclusion_email(@order).deliver_now
    redirect_to :back, notice: "Você concluiu o pedido #{@order.id}"
  end

  def set_collections
    @customers = Customer.all
    @products = Product.all
    if @order && @order.product_id
      @plans = Plan.find(:all, from: @order.product.plans_path)
      if @order.plan_id
        @periodicities = Price.find(:all, from: @order.plan.prices_path)
        set_periodicity if @order.periodicity_id
      end
    end
  end

  def set_periodicity
    @periodicity = @periodicities.find { |p| p.id == @order.periodicity_id }
  end

  def with_coupon
    @coupon = Coupon.find(order_params[:coupon])
    if @coupon
      @order.give_discount(@coupon.discount)
      @order.burn_coupon
      @order.save
      respond_with @order
    else
      flash[:alert] = 'Invalid coupon!'
      render :new
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
