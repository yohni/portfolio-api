class AddThumbnailUrlToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :thumbnail_url, :string
  end
end
