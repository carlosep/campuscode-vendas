FactoryGirl.define do
  factory :user do
    name 'Joao'
    sequence(:email){|n| "joao#{n}@gmail.com" }
    password '12345678'
  end
end
