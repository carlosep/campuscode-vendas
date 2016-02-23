class Customer < ActiveRecord::Base
  validates :name, :phone, :email, :address,
            :cpf_cnpj, :birth_date, presence: true

  validates :cpf_cnpj, :email, uniqueness: true
  validates_format_of :email,:with => Devise::email_regexp
  validates_cpf_or_cnpj :cpf_cnpj
  validates :contact_name, :razao_social, presence: { if: :check_for_cnpj }

  has_many :orders

  def check_for_cnpj
    cpf_cnpj.size == 14
  end
end
