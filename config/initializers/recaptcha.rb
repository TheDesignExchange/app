# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.public_key  = 'xxx'
  config.private_key = 'yyy'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end