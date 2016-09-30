if Rails.env.development? or Rails.env.test?
  mailgun_token = ENV["MAILGUN_PASSWORD"] #test account password
  domain = 'mailgun.org'
  user_name = 'postmaster@sandbox423e5292e666438983f8ae2612819549.mailgun.org'
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
