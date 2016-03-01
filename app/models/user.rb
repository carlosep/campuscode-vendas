class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable, :validatable, :timeoutable
  has_many :orders
end
