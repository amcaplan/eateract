json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :name, :cuisine_type, :url
  json.url recipe_url(recipe, format: :json)
end
