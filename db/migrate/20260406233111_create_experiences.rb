class CreateExperiences < ActiveRecord::Migration[8.1]
  def change
    create_table :experiences do |t|
      t.string :company, null: false
      t.string :role, null: false
      t.string :description
      t.string :location
      t.date :start_date, null: false
      t.date :end_date
      t.boolean :current, default: false
      t.integer :position

      t.timestamps
    end
  end
end
