class CreateArts < ActiveRecord::Migration[5.2]
  def change
    create_table :arts do |t|
      t.integer :user_id
      t.string :title
      t.text :detail
      t.string :image_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
