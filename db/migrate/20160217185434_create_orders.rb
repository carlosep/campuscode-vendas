class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :status, default: 'Aberto'
      t.string :product
      t.string :client

      t.timestamps null: false
    end
  end
end
