class OrdersController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit]
  before_action :set_order, only: [:show]
  respond_to :html
    def show
      respond_with @order
    end

    def new
      @order = Order.new
    end

    def create
      @order = Order.create(order_params)
      respond_with @order
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
