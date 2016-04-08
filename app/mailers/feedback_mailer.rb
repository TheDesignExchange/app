class FeedbackMailer < ActionMailer::Base
  default :to => "admin@thedesignexchange.org"

  def message_me(msg)
    @msg = msg
    if @msg.email.empty?
      @msg.email = "admin@thedesignexchange.org"
    end
    mail from: @msg.email, subject: "[Feedback] " + @msg.subject, body: @msg.content
  end
end
