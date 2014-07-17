json.array!(@felicas) do |felica|
  json.extract! felica, :id, :idm, :activation, :activated_at
  json.url felica_url(felica, format: :json)
end
