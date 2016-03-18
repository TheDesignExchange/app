if Rails.env.development? or Rails.env.test?
  mailgun_token = 'fde364a19893533a938a9acaadf98890' #test account password
else
  mailgun_token = ENV['MAILGUN_API_TOKEN']
end

ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address        => 'smtp.mailgun.org',
    :port           => 587,
    :domain         => 'mailgun.org',
    :authentication => :plain,
    :user_name      => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
    :password       => mailgun_token
  }
