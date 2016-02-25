class AddPriceToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :price, index: true, foreign_key: true
  end
end
