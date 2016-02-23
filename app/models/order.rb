class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  has_one :product
end
