class CustomerMailer < ApplicationMailer
  def welcome_email(customer)
    @customer = customer
    mail(to: @customer.email, subject: 'Welcome to My Awesome Site')
  end
end
