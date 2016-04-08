# config/initializers/recaptcha.rb
if Rails.env.development? or Rails.env.test?
  Recaptcha.configure do |config|
    config.public_key  = 'xxx'
    config.private_key = 'yyy'
  end
else
  Recaptcha.configure do |config|
    config.public_key  = ENV['CAPTCHA_SITE_KEY']
    config.private_key = ENV['CAPTCHA_SECRET_KEY']
  end
end
