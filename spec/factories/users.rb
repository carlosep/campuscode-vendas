FactoryGirl.define do
  factory :user do
    name 'Joao'
    sequence(:email, 'a') { |n| n + '@gmail.com' }
    password '12345678'
  end

  def random_name
    ('a'..'z').to_a.shuffle.join
  end
end
