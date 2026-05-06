class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :cover_image_url
      t.string :status, default: "draft"
      t.datetime :published_at
      t.integer :views_count, default: 0

      t.timestamps
    end
  end
end
