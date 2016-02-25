class AddPeriodicityToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :periodicity, index: true, foreign_key: true
  end
end
