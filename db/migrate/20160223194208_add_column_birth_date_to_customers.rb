class AddColumnBirthDateToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :birth_date, :date
  end
end
