class Customer < ActiveRecord::Base
  validates :name, :phone, :email, :address,
            :cpf_cnpj, :contact_name, presence: true

  validates_format_of :email,:with => Devise::email_regexp

  has_many :orders
end
