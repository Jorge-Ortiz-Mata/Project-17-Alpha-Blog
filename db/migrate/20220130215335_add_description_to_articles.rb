class AddDescriptionToArticles < ActiveRecord::Migration[7.0]

  # Adding this column within articles table. Table: Articles, Column_name: Description, Data_type: Text.

  def change
    add_column :articles, :description, :text
  end
end