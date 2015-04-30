json.array!(@calendars) do |calendar|
  json.extract! calendar, :id, :day_off, :date, :time_start, :time_stop, :user_id
  json.url calendar_url(calendar, format: :json)
end
