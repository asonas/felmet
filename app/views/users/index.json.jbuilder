json.array!(@users) do |user|
  json.extract! user, :id, :felica, :name
  json.url user_url(user, format: :json)
end
