Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  provider :stripe_connect, ENV['STRIPE_CLIENT_ID'], ENV['STRIPE_LIVE_SECRET_KEY']
  provider :quickbooks, ENV['QUICKBOOKS_CLIENT_ID'], ENV['QUICKBOOKS_SECRET']
end