class AddLiveUrlToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :live_url, :string
  end
end
