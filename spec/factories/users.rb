FactoryGirl.define do
  factory :user do
    name 'Joao'
    sequence(:email){"#{rand(10000).to_s}@gmail.com" }
    password '12345678'
  end
end
