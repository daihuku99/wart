class CreateExhibitionArts < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibition_arts do |t|
      t.integer :exhibition_id
      t.integer :art_id

      t.timestamps
    end
  end
end
