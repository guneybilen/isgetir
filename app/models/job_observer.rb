class JobObserver < ActiveRecord::Observer
  def after_create(job)
    Notifier.job_added(job).deliver if (Rails.env.production? || Rails.env.development?)
  end
end
