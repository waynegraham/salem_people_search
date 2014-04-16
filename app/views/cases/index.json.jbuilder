json.array!(@cases) do |case|
  json.extract! case, :id, :case_id, :doc_id, :type, :content
  json.url case_url(case, format: :json)
end
