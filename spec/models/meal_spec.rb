require 'spec_helper'

describe Meal do
  let_statements

  before :each do
    person; recipe1; recipe2; topic1; meal1; meal2; mealperson1; mealperson2; rating1; rating2; rating3
  end

  it "has a date" do
    expect(meal1.time).not_to be_nil
  end

  it "validates date" do
    expect(Meal.new.save).to be_false
  end

  it "has ratings" do
    expect(meal1.ratings.size).to eq(2)
  end

  it "can average its ratings" do
    expect(meal1.average_rating).to eq(4.25)
  end
end
