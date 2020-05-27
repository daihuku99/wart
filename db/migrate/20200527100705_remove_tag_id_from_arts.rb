class RemoveTagIdFromArts < ActiveRecord::Migration[5.2]
  def change
    remove_column :arts, :tag_id, :integer
  end
end
