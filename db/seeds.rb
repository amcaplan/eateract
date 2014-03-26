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
  
  topic1 = Topic.create(name: "Attitudes Toward Death")
  topic2 = Topic.create(name: "The Internet and Society")
  topic3 = Topic.create(name: "Short-term vs. Long-term Thinking in Life and Business")

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
  topic1.links = [link1, link2, link3, link4, link5, link6, link7]

  link8 = Link.create(name: "Study Of Internet Isolation Provides Chat Room Grist",
    link_type: "article",
    url: "http://articles.chicagotribune.com/2000-02-17/news/0002170312_1_internet-isolate-stanford-study",
    summary: "One sure sign that a new technology has taken hold: The cultural Paul Reveres saddle up, warning the citizens about impending invasion. But is there really any reason to double-check the locks?")
  link9 = Link.create(name: "Internet Addiction Targeted In South Korea",
    link_type: "article",
    url: "http://www.huffingtonpost.com/2010/04/22/internet-addiction-target_n_547747.html",
    summary: "Day and night, Lee Mi-hwa's son stays on his computer, slaying dragons in his online fantasy world while his dinner and homework sit untouched. Lee says the 15-year-old fights her attempts to get him to log off, screaming and physically lashing out at her entreaties.")
  link10 = Link.create(name: "Do social networking sites improve your ability to network in real life?",
    link_type: "article",
    url: "http://computer.howstuffworks.com/internet/social-networking/information/social-networking-sites-improve-your-ability-to-network.htm",
    summary: "Do social networking sites improve networking? See if your connections help in real life and if social networking sites improve networking potential.")
  link11 = Link.create(name: "The CMU HomeNet Study",
    link_type: "study",
    url: "http://cs.stanford.edu/people/eroberts/cs181/projects/2000-01/personal-lives/cmu.html",
    summary: "A longitudinal study by Carnegie-Mellon University's HomeNet Project found that increased Internet use correlated (and likely caused) a decrease in social involvement. While we lack some of the data necessary to validate this claim, the study makes perhaps the strongest case for a link between Internet use and isolation.")
  link12 = Link.create(name: "How the web is improving the lives of disabled computer users",
    link_type: "article",
    url: "http://www.techradar.com/us/news/internet/how-the-web-is-improving-the-lives-of-disabled-computer-users-684644",
    summary: "The internet has improved the lives of disabled computer users, while new technology has made almost universal access possible.")
  link13 = Link.create(name: "Three Days in Cyberspace (1995 article)",
    link_type: "article",
    url: "http://www.inc.com/magazine/19951215/2652.html",
    summary: "An Inc. writer tries to live three days in cyberspace, with only his computer to connect with the world.")
  link14 = Link.create(name: "How the Online Society of Gamers Improves Life for Everyone",
    link_type: "article",
    url: "http://www.examiner.com/article/how-the-online-society-of-gamers-improves-life-for-everyone",
    summary: "In the technological age, it is not surprising that a major innovation has come in the way we now attempt to solve these challenges, using computers. What may surprise many is that the emerging combined art of video games have come to the forefront of this battle for man's health in a new and innovative way.")
  topic2.links = [link8, link9, link10, link11, link12, link13, link14]

  link15 = Link.create(name: "Setting Smart Management Goals",
    link_type: "article",
    url: "http://www.dummies.com/how-to/content/setting-smart-management-goals.html",
    summary: "How do you know what kind of goals to set? The best goals are SMART goals.")
  link16 = Link.create(name: "Nickelback - If Today Was Your Last Day [OFFICIAL VIDEO]",
    link_type: "video",
    url: "https://www.youtube.com/watch?v=lrXIQQ8PeRs&feature=kp",
    summary: '"If today was your last day / And tomorrow was too late / Could you say goodbye to yesterday?"')
  link17 = Link.create(name: "The Jeff Bezos School of Long-Term Thinking",
    link_type: "article",
    url: "http://99u.com/articles/7255/the-jeff-bezos-school-of-long-term-thinking",
    summary: "Obey the two pizza rule and other ways to plan for the future, as inspired by Amazon's CEO.")
  link18 = Link.create(name: "A Farm’s Lessons in Long-Term Planning",
    link_type: "article",
    url: "http://www.nytimes.com/2014/02/03/your-money/a-farms-lessons-in-long-term-planning.html",
    summary: "What may seem like a great decision now could be unsustainable in five or even 10 years and could easily undermine years of work.")
  link19 = Link.create(name: "Living in the moment really does make people happier",
    link_type: "article",
    url: "http://www.theguardian.com/science/2010/nov/11/living-moment-happier",
    summary: "Psychologists have found that people are distracted from the task at hand nearly half the time, and this daydreaming consistently makes them less happy.")
  link20 = Link.create(name: "Planning for the future: On the behavioral economics of living longer",
    link_type: "article",
    url: "http://www.bringyourchallenges.com/roundtable/planning-for-the-future",
    summary: "Our brains aren’t wired to plan for the long run. But if we can understand the behaviors that are tripping us up, we can find ways to work around them.")
  link21 = Link.create(name: "If You Want To Be Successful, Don't Spend Too Much Time Planning: A Case Study",
    link_type: "article",
    url: "http://www.forbes.com/sites/actiontrumpseverything/2013/05/19/if-you-want-to-be-successful-dont-spend-too-much-time-planning-a-case-study/",
    summary: "The most succesful people take small, smart steps toward their goals...and they don&#39;t over-plan.")
  topic3.links = [link15, link16, link17, link18, link19, link20, link21]
  
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