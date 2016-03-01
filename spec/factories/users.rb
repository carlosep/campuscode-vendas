FactoryGirl.define do
  factory :user do
    name 'Joao'
    sequence(:email) { |n| "user#{n}@vendas.com" }
    password '12345678'
  end
end
