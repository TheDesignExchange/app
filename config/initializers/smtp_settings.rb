if Rails.env.development? or Rails.env.test?
  mailgun_token = 'fde364a19893533a938a9acaadf98890' #test account password
  domain = 'mailgun.org'
  user_name = 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org'
else
  mailgun_token = ENV['MAILGUN_PASSWORD']
  domain = 'thedesignexchange.org'
  user_name = 'postmaster@thedesignexchange.org'
end

ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address        => 'smtp.mailgun.org',
    :port           => 587,
    :domain         => domain,
    :authentication => :plain,
    :user_name      => user_name,
    :password       => mailgun_token
  }
