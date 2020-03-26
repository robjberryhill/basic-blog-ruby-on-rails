class AddPasswordDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    # what is created, on what table, with what name, and what type.
    add_column :users, :password_digest, :string
  end
end
