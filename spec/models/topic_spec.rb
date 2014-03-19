require 'spec_helper'

describe Topic do
  let_statements
  before :each do
    person; recipe1; recipe2; topic1; meal1; meal2; mealperson1; mealperson2; rating1; rating2; rating3
end

  it "has a name" do
    expect(topic1.name).to eq("Global Warming")
  end

  it "has ratings" do
    expect(topic1.ratings.first.number).to eq(4.5)
  end

  it "can average its ratings" do
    expect(topic1.average_rating).to eq(4.25)
  end
end
