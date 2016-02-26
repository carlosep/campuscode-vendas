class CustomerMailer < ApplicationMailer
  def welcome_email(customer)
    @customer = customer
    mail(to: @customer.email, subject: 'Welcome!')
  end

  def conclusion_email(order)
    @customer = order.customer
    @order = order
    mail(to: @customer.email, subject: 'Order information!')
  end
end
