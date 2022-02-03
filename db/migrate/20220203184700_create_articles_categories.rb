class CreateArticlesCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :articles_categories do |t|

      t.timestamps
    end
  end
end
