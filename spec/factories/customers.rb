FactoryGirl.define do
  factory :customer do
    name 'João'
    sequence(:email) { |n| "user#{n}@vendas.com" }
    phone '12 3231221312'
    address 'Av alameda'
    cpf_cnpj '81239932006'
    contact_name 'Maria'
    birth_date '1995/3/16'
  end
end
