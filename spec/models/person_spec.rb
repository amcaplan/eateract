require 'spec_helper'

describe Person do
  let_statements

  before :each do
    person; recipe1; recipe2; topic1; meal1; meal2; mealperson1; mealperson2; rating1; rating2; rating3
  end

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
    expect(person.average_rating).to eq(4.25)
  end
  
  it "has meals" do
    expect(person.meals.size).to eq(2)
  end
end
