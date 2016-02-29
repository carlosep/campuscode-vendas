class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :customer
  validates :product_id, :plan_id, :customer_id, :periodicity_id, presence: true

  def product
    Product.find(product_id)
  end

  def plan
    Plan.find(plan_id)
  end

  def product=(product)
    product_id = product.id
  end

  def plan=(plan)
    plan_id = plan.id
  end

  def periodicity
    Periodicity.find(periodicity_id)
  end

  def give_discount(discount)
    self.price = (price * (1 - (discount/100))).round(2)
  end

  def burn_coupon
    Coupon.post("#{coupon}/burn",{client_name: customer.name,
                                  client_phone: customer.name,
                                  salesman_name: user.name,
                                  discount_value: Coupon.find(coupon).discount})
  end
end
