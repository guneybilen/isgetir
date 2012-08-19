class Notifier < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_friend.subject
  #
  def email_friend(job, sender_name, receiver_email)
    @job = job
    @sender_name = sender_name
    mail :to => receiver_email, :subject => "Interesting Job", :from =>  "admin@isgetir.com"
  end

  def comment_added(comment)
    @job = comment.job
    mail :to => @job.user.email,
         :subject => "New comment for '#{@job.title}'", :from =>  "admin@isgetir.com"
  end

  def user_added(user)
    @user = user
     mail :to => "guneybilen@yahoo.com",
         :subject => "New user for #{@user.email}",
         :from =>  "admin@isgetir.com"
  end

   def job_added(job)
    @job = job
     mail :to => "guneybilen@yahoo.com",
         :subject => "#{@job.user.email} user added a new job: #{@job.title}",
         :from =>  "admin@isgetir.com"
  end
end
