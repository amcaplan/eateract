require 'spec_helper'
require_relative '../controllers_spec_helper'

describe MealsController do
  context 'Logged in' do
    before :all do
      login
    end

    after :all do
      logout
    end
  end

end