class AddDescriptionToArticles < ActiveRecord::Migration[5.2]
  def change
    # what is created, on what table, with what name, and what type.
    add_column :articles, :description, :text
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
  end
end
