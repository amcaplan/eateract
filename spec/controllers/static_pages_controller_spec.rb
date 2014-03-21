require 'spec_helper'

describe StaticPagesController do
  context 'Homepage' do
    describe 'GET /' do
      it 'renders the homepage' do
        get :index
        expect(response).to render_template("index")
      end
    end
  end
end
