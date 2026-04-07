class AddUserRefToExperiences < ActiveRecord::Migration[8.1]
  def change
    add_reference :experiences, :user, null: false, foreign_key: true
  end
end
