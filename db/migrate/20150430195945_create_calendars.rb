class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.boolean :day_off
      t.string :date
      t.time :time_start
      t.time :time_stop
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
