json.array!(@interests) do |interest|
  json.extract! interest, :id, :name, :category_id
  json.url interest_url(interest, format: :json)
end
