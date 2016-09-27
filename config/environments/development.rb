DesignExchange::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false


  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Action Mailer settings
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.smtp_settings = {
   :address              => "smtp.gmail.com",
   :port                 => 587,
   :user_name            => ENV['gmail_username'],
   :password             => ENV['gmail_password'],
   :authentication       => "plain",
   :enable_starttls_auto => true,
   :openssl_verify_mode => 'none'

  }
  config.action_mailer.delivery_method = :smtp

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
  config.assets.digest = true

  # Devise config
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

  # Eager load
  config.eager_load = false

  # Lograge
  config.lograge.enabled = true
  # SMTP settings for gmail
  config.assets.raise_runtime_errors = true



end
