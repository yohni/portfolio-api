class CreateUploads < ActiveRecord::Migration[8.1]
  def change
    create_table :uploads do |t|
      t.string :file_url
      t.string :og_filename
      t.string :file_type
      t.integer :file_size

      t.timestamps
    end
  end
end
