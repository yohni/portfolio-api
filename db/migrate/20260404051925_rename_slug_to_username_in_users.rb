class RenameSlugToUsernameInUsers < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :slug, :username
  end
end
