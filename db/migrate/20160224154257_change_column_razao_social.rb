class ChangeColumnRazaoSocial < ActiveRecord::Migration
  def change
    rename_column :customers, :razao_social, :company_name
  end
end
