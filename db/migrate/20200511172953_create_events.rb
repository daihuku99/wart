class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :detail
      t.integer :event_type, default: 0, null: false
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
