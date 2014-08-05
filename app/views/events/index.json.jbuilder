json.array!(@events) do |event|
  json.extract! event, :id, :user_id, :checkin_at, :checkout_at
  json.url event_url(event, format: :json)
end
