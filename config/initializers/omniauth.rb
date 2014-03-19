OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1433301626912409', ENV['FACEBOOK_APP_SECRET']
end