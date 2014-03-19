require 'spec_helper'

describe Person do
  let (:person) {Person.create(name: "Ariel Caplan", email: "fake_email@aol.com")}
  let (:rating1) {Rating.create(person: person, number: 4.5)}
  let (:rating2) {Rating.create(person: person, number: 4)}

  it "has a name" do
    expect(person.name).to eq("Ariel Caplan")
  end

  it "has an email" do
    expect(person.email).to eq("fake_email@aol.com")
  end

  it "has ratings" do
    rating1; rating2 # Initialize the values
    expect(person.ratings.first).to eq(rating1)
  end

  it "can average its ratings" do
    expect(person.average_rating).to eq(4.75)
  end
  
  it "has meals" do
  end
end
