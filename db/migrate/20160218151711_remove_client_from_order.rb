class RemoveClientFromOrder < ActiveRecord::Migration
  def change
    remove_column :orders, :client, :string
  end
end
