json.array!(@mentions) do |mention|
  json.extract! mention, :id, :case_id, :name_id
  json.url mention_url(mention, format: :json)
end
