# Replace the following with actual domain and key management system

ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address        => 'smtp.mailgun.org',
    :port           => 587,
    :domain         => 'mailgun.org',
    :authentication => :plain,
    :user_name      => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
    :password       => 'fde364a19893533a938a9acaadf98890'
  }