FactoryGirl.define do
  factory :order do
    status "Aberto"
    product "Produto"
    client "Cliente"
  end
end
