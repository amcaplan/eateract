require 'spec_helper'

describe User do
  let(:user) {User.create(name: "Hello Face", email: "hello@world.com")}

  it "has a name" do
    expect(user.name).to eq("Hello Face")
  end

  it "has an email" do
    expect(user.email).to eq("hello@world.com")
  end
end
