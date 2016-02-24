class AddPlanToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :plan, index: true, foreign_key: true
  end
end
