class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer

  def product
    Product.find(product_id).product
  end

  def product=(product)
    product_id = product.id
  end
  
  def periodicity
    Periodicity.find(periodicity_id)
  end

  def periodicity=(periodicity)
    periodicity_id = periodicity.id
  end
end
