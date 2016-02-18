class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :cpf_cnpj
      t.string :contact_name

      t.timestamps null: false
    end
  end
end
