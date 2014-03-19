require 'spec_helper'

describe Recipe do
  let_statements

  before :each do
    person; recipe1; recipe2; topic1; meal1; meal2; mealperson1; mealperson2; rating1; rating2; rating3
  end

  it "has a name" do
    expect(recipe1.name).to eq("steak")
  end

  it "has a cuisine type" do
    expect(recipe1.cuisine_type).to eq("American")
  end

  it "has a url" do
    expect(recipe1.url).to eq("example.com")
  end

  it "validates name" do
    recipe = Recipe.new(cuisine_type: "American", url: "example.com")
    expect(recipe.save).to be_false
  end

  it "validates url" do
    recipe = Recipe.new(name: "steak", cuisine_type: "American")
    expect(recipe.save).to be_false
  end

  it "can average its ratings" do
    expect(recipe1.average_rating).to eq(4.25)
  end
end
