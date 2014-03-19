OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1433301626912409', '9c02cab85e4ecf966af7486cada6660d'
end