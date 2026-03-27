class AddPositionToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :position, :integer
  end
end
