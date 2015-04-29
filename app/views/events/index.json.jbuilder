json.array!(@events) do |event|
  json.extract! event, :id, :name, :description, :user_id, :start_date, :stop_date
  json.url event_url(event, format: :json)
end
