class AddExhibitionIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :exhibition_id, :integer
  end
end
