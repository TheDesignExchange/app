class UserMailer < ActionMailer::Base
  default from: "notification@thedesignexchange.org"

  def approval_email(user,method)
    @user = user
    @method = method
    if Rails.env.development? or Rails.env.test?
	  mail({
        :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
        :to      => @user.email,
        :subject => "Method ready for approval",
      })
    else
	  mail({
        :from    => 'postmaster@thedesignexchange.org',
        :to      => @user.email,
        :subject => "Method ready for approval",
      })
    end
  end

  def cs_approval_email(user,case_study)
    @user = user
    @cs = case_study
    if Rails.env.development? or Rails.env.test?
	  mail({
        :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
        :to      => @user.email,
        :subject => "Case study ready for approval",
      })
    else
	  mail({
        :from    => 'postmaster@thedesignexchange.org',
        :to      => @user.email,
        :subject => "Case study ready for approval",
      })    	
    end
  end

  def publication_email(user, method)
    @user = user
    @method = method
    if Rails.env.development? or Rails.env.test?
      mail({
        :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
        :to      => @user.email,
        :subject => "Method published.",
      })
    else
      mail({
        :from    => 'postmaster@thedesignexchange.org',
        :to      => @user.email,
        :subject => "Method published",
      })    	    	
    end
  end

  def cs_publication_email(user, case_study)
  	@user = user
  	@cs = case_study
    if Rails.env.development? or Rails.env.test?
      mail({
        :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
        :to      => @user.email,
        :subject => "Method published.",
      })
    else
      mail({
        :from    => 'postmaster@thedesignexchange.org',
        :to      => @user.email,
        :subject => "Method published",
      })    	    	
    end
  end

  def admin_changes_email(user,method)
  	@user = user
  	@method = method
    if Rails.env.development? or Rails.env.test?
      mail({
        :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
        :to      => @user.email,
        :subject => "An administrator has made changes to your method",
      })
    else
      mail({
        :from    => 'postmaster@thedesignexchange.org',
        :to      => @user.email,
        :subject => "An administrator has made changes to your method",
      })    	    	
    end
  end

  def cs_made_changes_email(user, case_study)
  	@user = user
  	@mcs = case_study
    if Rails.env.development? or Rails.env.test?
      mail({
        :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
        :to      => @user.email,
        :subject => "An administrator has made changes to your case study",
      })
    else
      mail({
        :from    => 'postmaster@thedesignexchange.org',
        :to      => @user.email,
        :subject => "An administrator has made changes to your case study",
      })    	    	
    end
  end
end
