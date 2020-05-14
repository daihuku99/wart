class AddArtIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :art_id, :integer
  end
end
