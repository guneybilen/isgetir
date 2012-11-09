class UserObserver < ActiveRecord::Observer
   def after_create(user)
     Notifier.user_added(user).deliver if (Rails.env.production? || Rails.env.development?)
  end
end
