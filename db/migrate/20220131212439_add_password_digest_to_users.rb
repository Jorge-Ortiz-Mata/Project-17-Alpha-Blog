class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]

  # Adding this column within articles table. Table: users, Column_name: password_digest, Data_type: string.

  def change
    add_column :users, :password_digest, :string
  end
end
