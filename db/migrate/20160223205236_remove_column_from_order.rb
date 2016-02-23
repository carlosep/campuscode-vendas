class RemoveColumnFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :product, :string
  end
end
