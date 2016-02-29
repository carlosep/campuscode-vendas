class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      CustomerMailer.welcome_email(@customer).deliver_now
    end
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

  def search
    @customer = Customer.find_by(cpf_cnpj: search_params)
    if @customer.nil?
      flash[:alert] = 'Customer not found'
      redirect_to root_path
    else
      redirect_to @customer
    end
  end

  private

  def customer_params
    params.require(:customer)
          .permit(:name, :email, :phone, :address, :cpf_cnpj,
                  :contact_name, :company_name, :birth_date)
  end

  def search_params
    search = params.require(:search).permit(:query)
    search[:query]
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
