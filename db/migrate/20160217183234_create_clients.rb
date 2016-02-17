class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :address
      t.string :cpf_cnpj
      t.string :contact

      t.timestamps null: false
    end
  end
end
