class AddTokenToSessionsAgain < ActiveRecord::Migration[8.1]
  def up
    add_column :sessions, :token, :string, null: false, default: ""
    Session.reset_column_information

    Session.unscoped.where(token: [ nil, "" ]).find_each do |session|
      session.update_column(:token, SecureRandom.urlsafe_base64(32))
    end

    change_column_null :sessions, :token, false
    add_index :sessions, :token, unique: true
  end

  def down
    remove_index :sessions, :token if index_exists?(:sessions, :token, unique: true)
    remove_column :sessions, :token
  end
end
