class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable,  and :omniauthable,  :registerable, :recoverable, :rememberable,
  devise :database_authenticatable, :trackable, :validatable, :timeoutable
  has_many :orders
end
