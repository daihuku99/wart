class CreateExhibitions < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibitions do |t|
      t.integer :user_id
      t.string :title
      t.text :detail
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
