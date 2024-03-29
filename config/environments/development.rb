Tabelia::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = true
  
  config.action_mailer.delivery_method = :ses

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false
  
  config.cache_store = :redis_store

  # Expands the lines which load the assets
  config.assets.debug = true
  
  #config.serve_static_assets = false
  #config.action_controller.asset_host = "s3-eu-west-1.amazonaws.com/assets.tabelia.com"
  
  
  
  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    paypal_options = {
        :login => "a.fern_1320663000_biz_api1.retocontinuo.com",
        :password => "1320663030",
        :signature => "ApO-tASkDf1PB5fLhBpBkWeFZYLhAnEdJ.EyzU0bhJtqvpyN.dtHCG9C"
      }
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end
end
