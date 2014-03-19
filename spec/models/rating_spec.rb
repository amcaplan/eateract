require 'spec_helper'

describe Rating do
  let_statements

  it "has a number" do
    expect(rating1.number).to eq(4.5)
  end

  it "stores its number as a decimal" do
    expect(rating1.number.class).to eq(Float)
  end

  it "has a meal" do
    expect(rating1.meal).to eq(meal1)
    expect(rating2.meal).to eq(meal2)
  end
end
