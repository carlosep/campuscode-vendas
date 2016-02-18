class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.create(customer_params)
    respond_with @customer
  end

  def show
  end

  def edit
  end

  def update
    @customer.update(customer_params)
    respond_with @customer
  end

  private

  def customer_params
    params.require(:customer)
          .permit(:name, :email, :phone, :address, :cpf_cnpj, :contact_name)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
