class CreateTags < ActiveRecord::Migration[8.1]
  def change
    create_table :tags do |t|
      t.string :name, null: false
      t.string :slug

      t.timestamps
    end
    add_index :tags, [:name, :slug], unique: true
  end
end
