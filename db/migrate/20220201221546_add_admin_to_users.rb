class AddAdminToUsers < ActiveRecord::Migration[7.0]

  # Adding this column within articles table. Table: users, Column_name: admin, Data_type: boolean, Default status: false.

  def change
    add_column :users, :admin, :boolean, default: false
  end
end
