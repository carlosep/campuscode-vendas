FactoryGirl.define do
  factory :order do
    status "Aberto"
    customer
    user
  end
end
