json.array!(@meals) do |meal|
  json.extract! meal, :id, :time, :topic_id, :cuisine_type
  json.url meal_url(meal, format: :json)
end
