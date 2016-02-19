class Customer < ActiveRecord::Base
  validates :name, :phone, :email, :address,
            :cpf_cnpj, presence: true
  validates_format_of :email,:with => Devise::email_regexp
  validates_cpf_or_cnpj :cpf_cnpj
  validates :contact_name, presence: { if: :check_for_cnpj }

  has_many :orders

  def check_for_cnpj
    return true if cpf_cnpj.size == 14
    false
  end
end
