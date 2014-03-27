# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Eateract::Application.initialize!
Eateract::Application.configure do
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
end