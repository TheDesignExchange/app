class UserMailer < ActionMailer::Base
  default from: "dxnotificationsystem@gmail.com"

  def seeking_approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Design method ready for Approval')
  end
end
