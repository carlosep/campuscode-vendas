class AddColumnRazaoSocialToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :razao_social, :string
  end
end
