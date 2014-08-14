json.array!(@posts) do |post|
  json.extract! post, :id, :template_name, :title, :body
  json.url post_url(post, format: :json)
end
