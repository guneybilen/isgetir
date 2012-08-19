class UserObserver < ActiveRecord::Observer
   def after_create(user)
     Notifier.user_added(user).deliver
  end
end
