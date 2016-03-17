class FeedbackMailer < ActionMailer::Base
	# replace with admin@designexchange.org
  default :to => "jennyli@berkeley.edu"

	def message_me(msg)
		@msg = msg
		if @msg.email.empty?
			# replace with admin@designexchange.org
			@msg.email = "postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org"
		end
		mail from: @msg.email, subject: "[Feedback] " + @msg.subject, body: @msg.content
	end
end
