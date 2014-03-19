json.array!(@ratings) do |rating|
  json.extract! rating, :id, :number, :meal_id, :person_id
  json.url rating_url(rating, format: :json)
end
