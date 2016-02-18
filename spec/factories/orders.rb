FactoryGirl.define do
  factory :order do
    status "Aberto"
    product "Produto"
    customer
    user
  end
end
