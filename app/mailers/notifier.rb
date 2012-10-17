class Notifier < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_friend.subject
  #




  # :to, :subject, :from - bu ucu gerekiyor methodlarda. yada
  # en yukarda class'dan sonra :default declare ediceksin





  def email_friend(job, sender_name, receiver_email)
    @job = job
    @sender_name = sender_name
    mail :to => receiver_email, :subject => t('general.interesting_job'), :from =>  "admin@isgetir.com"
  end

  def comment_added(comment)
    @job = comment.job
    mail :to => @job.user.email,
         :subject => t('general.new_comment_for') + " #{@job.title}", :from =>  "admin@isgetir.com"
  end

  def user_added(user)
    @user = user
    mail :to => "guneybilen@yahoo.com",
         :subject => t('general.new_user_with') + " #{@user.email}",
         :from =>  "admin@isgetir.com"
  end

  def job_added(job)
    @job = job
    mail :to => "guneybilen@yahoo.com",
         :subject => "#{@job.user.email} " + t('general.user_added_a_new_job') + "  #{@job.title}",
         :from =>  "admin@isgetir.com"
  end


  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => t('general.password_reset'),
         :from =>  "admin@isgetir.com"
  end
end

