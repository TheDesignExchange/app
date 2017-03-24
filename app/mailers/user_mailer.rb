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

  def cs_admin_changes_email(user, case_study)
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

  def invitation_email(email,user)
    @user = user
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

  def share_method_email(email,user,method)
    @user = user
    @method = method
    @name = nil
    if @user
      @name = @user.first_name
    else
      @name = "An anonymous user"
    end
    if Rails.env.development? or Rails.env.test?
      mail({
          :from    => 'postmaster@sandbox3419534bf0ee465fb886bc9f1ada4faa.mailgun.org',
          :to      => email,
          :subject => @name + " shared a method with you!",
        })
    else
      mail({
          :from    => 'postmaster@thedesignexchange.org',
          :to      => email,
          :subject => @name + " shared a method with you!",
        })
    end
  end

end
