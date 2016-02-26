FactoryGirl.define do
  factory :order do
    status "Aberto"
    product_id 1
    periodicity_id 1
    plan_id 2
    customer
    user
  end
end
