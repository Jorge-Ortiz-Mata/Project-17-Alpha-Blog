class AddUserIdToArticles < ActiveRecord::Migration[7.0]

  # Adding this column within articles table. Table: articles, Column_name: user_id, Data_type: integer.

  def change
    add_column :articles, :user_id, :integer
  end
end
