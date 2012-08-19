class JobObserver < ActiveRecord::Observer
  def after_create(job)
    Notifier.job_added(job).deliver
  end
end
