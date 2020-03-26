class AddUserIdToArticles < ActiveRecord::Migration[5.2]
  def change
    # what is created, on what table, with what name, and what type.
    add_column :articles, :user_id, :integer
  end
end
