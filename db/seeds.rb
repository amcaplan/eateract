# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  person1 = Person.create(name: "Ariel Caplan", email: ENV["ARIELS_EMAIL"])
  person2 = Person.create(name: "Nonexistent Person", email: "fake_email@gmail.com")
  
  recipe1 = Recipe.create(name: "steak", cuisine_type: "American food", url: "example.com")
  Recipe.create(name: "French fries", cuisine_type: "American", url: "example2.com/fries")
  
  topic1 = Topic.create(name: "Global Warming")
  topic2 = Topic.create(name: "Attitudes Toward Death")

  link1 = Link.create(name: "Harry Potter and Running from Death",
    link_type: "article",
    url: "http://www.frontporchrepublic.com/2011/08/harry-potter-and-death/",
    summary: "Our hero, Harry, demonstrates an attitude towards death that very few of us actually hold.")
  link2 = Link.create(name: "Forever 21: America's Fear of Aging and Death",
    link_type: "article",
    url: "http://www.examiner.com/article/forever-21-america-s-fear-of-aging-and-death",
    summary: "American culture is one in which youth, beauty, and slimness" +
      " are highly valued and perpetuated by media with mental health, " +
      "physical health, and spirituality taking a backburner in the chase for agele")
  link3 = Link.create(name: "The greatest death scenes in literature",
    link_type: "article",
    url: "http://www.theguardian.com/books/booksblog/2011/sep/29/greatest-death-scenes-literature",
    summary: "Very hard to bring off without bathos, final moments wrong-footed even Charles Dickens and George Eliot")
  link4 = Link.create(name: "Death Be Not Decaffeinated: Over Cup, Groups Face Taboo",
    link_type: "article",
    url: "http://newoldage.blogs.nytimes.com/2013/06/16/death-be-not-decaffeinated-over-cup-groups-face-taboo/?_php=true&_type=blogs&_r=0",
    summary: "An informal group called Death Cafe meets monthly in New York" +
      " to bat around philosophical thoughts on death and dying. It's one" +
      " of many such gatherings that have sprung up around the country.")
  link5 = Link.create(name: "Our unrealistic attitudes about death, through a doctor’s eyes",
    link_type: "article",
    url: "http://www.washingtonpost.com/opinions/our-unrealistic-views-of-death-through-a-doctors-eyes/2012/01/31/gIQAeaHpJR_story.html",
    summary: "When medical care amounts to torture.")
  link6 = Link.create(name: "Elephants grieving - BBC wildlife",
    link_type: "video",
    url: "http://www.youtube.com/watch?v=C5RiHTSXK2A",
    summary: "Watch this moving video as the wild herd stumble across an " +
      "elephant carcass and ceremoniously touch the bones, as if grieving " +
      "for their loss. From the BBC")
  link7 = Link.create(name: "An Online Generation Redefines Mourning",
    link_type: "article",
    url: "http://www.nytimes.com/2014/03/23/fashion/an-online-generation-redefines-mourning.html?hpw&rref=fashion&_r=1&gwh=D9A3D29386B12753993E067FE6145F05&gwt=regi",
    summary: "Expressions of grief take on many public forms in the digital age.")
  topic2.links = [link1, link2, link3, link4, link5, link6, link7]
  
  meal1 = Meal.create(time: Chronic.parse("one week from today"))
  meal1.save
  meal1.topic = topic1
  meal1.add_recipe(recipe1)
  meal1.save
  
  meal2 = Meal.create(time: Chronic.parse("two weeks from today"))
  meal2.save
  meal2.topic = topic1
  meal2.add_recipe(recipe1)
  meal2.save
  
  MealPerson.create(host: true, host_relationship: 'self', person: person1, meal: meal1)
  MealPerson.create(host: true, host_relationship: 'family', person: person2, meal: meal1)
  MealPerson.create(host: false, host_relationship: 'family', person: person1, meal: meal2)
  MealPerson.create(host: false, host_relationship: 'self', person: person2, meal: meal2)
  
  Rating.create(person: person1, number: 4.5, meal: meal1)
  Rating.create(person: person2, number: 4, meal: meal1)
  Rating.create(person: person2, number: 4, meal: meal2)