class AddDescriptionToArticles < ActiveRecord::Migration[7.0]

  # Adding this column within articles table. Table: articles, Column_name: description, Data_type: text.

  def change
    add_column :articles, :description, :text
  end
end