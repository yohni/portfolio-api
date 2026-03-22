class RemoveTokenFromSessions < ActiveRecord::Migration[8.1]
  def change
    remove_column :sessions, :token, :string
  end
end
