class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.integer :user_id
      t.datetime :start_date
      t.datetime :stop_date

      t.timestamps null: false
    end
  end
end
