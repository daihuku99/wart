class CreateCartArts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_arts do |t|
      t.integer :user_id
      t.integer :art_id

      t.timestamps
    end
  end
end
