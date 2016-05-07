Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Settings.provider.twitter.api_key, Settings.provider.twitter.api_secret
end
