class UserMailer < ActionMailer::Base
  default from: "dxnotificationsystem@gmail.com"

  def approval_email(user,method)
    @user = user
    @method = method
    mail({
      :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
      :to      => @user.email,
      :subject => "Method ready for approval",
    })
  end

  def cs_approval_email(user,case_study)
  end

  def ready_for_publication_email(user, method)
  end

  def cs_ready_for_publication_email(user, case_study)
  end

  def admin_made_changes_email(user,method)
  end

  def cs_admin_made_changes_email(user, case_study)
  end
end
