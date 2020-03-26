class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    # what is created, on what table.
    create_table :articles do |t|
      # type and name of column.
      t.string :title
    end
  end
end
