class FeedbackMailer < ActionMailer::Base
  default :to => "jennyli@berkeley.edu"

	def message_me(msg)
		@msg = msg
		mail from: @msg.email, subject: @msg.subject, body: @msg.content
	end
end
