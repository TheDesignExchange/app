class ApplicationMailer < ActionMailer::Base
  default from: "admin@thedesignexchange.org"
  layout 'mailer'

  def invitation_email(email)
    if Rails.env.development? or Rails.env.test?
	  mail({
        :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
        :to      => email,
        :subject => "Invitation to join theDesignExchange!",
      })
    else
	  mail({
        :from    => 'postmaster@thedesignexchange.org',
        :to      => email,
        :subject => "Invitation to join theDesignExchange!",
      })
    end
  end
end
