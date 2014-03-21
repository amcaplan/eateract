namespace :db do
  desc "SEED THE DATABASE"
  task seed: :environment do
    person = Person.create(name: "Ariel Caplan", email: "fake_email@aol.com")
    
    recipe1 = Recipe.create(name: "steak", cuisine_type: "American food", url: "example.com")
    Recipe.create(name: "French fries", cuisine_type: "American", url: "example2.com/fries")
    
    topic1 = Topic.create(name: "Global Warming")
    
    meal1 = Meal.create(time: Time.now, cuisine_type: "American food")
    meal1.save
    meal1.topic = topic1
    meal1.add_recipe(recipe1)
    meal1.save
    
    meal2 = Meal.create(time: Time.now, cuisine_type: "American food")
    meal2.save
    meal2.topic = topic1
    meal2.add_recipe(recipe1)
    meal2.save
    
    MealPerson.create(host: true, host_relationship: 'self', person: person, meal: meal1)
    MealPerson.create(host: false, host_relationship: 'family', person: person, meal: meal2)
    
    Rating.create(person: person, number: 4.5, meal: meal1)
    Rating.create(person: person, number: 4, meal: meal2)
    Rating.create(number: 4, meal: meal1)
  end
end
