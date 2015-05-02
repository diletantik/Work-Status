class AddDescriptionToCalendar < ActiveRecord::Migration
  def change
    add_column :calendars, :description, :text
  end
end
