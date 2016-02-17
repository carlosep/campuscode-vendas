class OrdersController < ApplicationController
  before_action :set_collections, only: [:new, :create, :edit]
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
      @user = User.all
    end

    def order_params
      params.require(:order)
            .permit(:status, :product, :client, :user_id)
    end
  end
