FactoryGirl.define do
  factory :client do
    name "Joao"
    sequence(:email, 'a') { |n| n + '@gmail.com' }
    phone "12345678"
    address "Rua dos Doces"
    cpf_cnpj "12345678910"
    contact "Maria"
  end
end
