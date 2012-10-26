
class Session < ActiveRecord::Base

  attr_accessible  # none icin hicbir symbol vermesen yetiyor


  def self.check_date  #check_date method is called from sessions_controller#destroy
    time = 1.month.ago.to_s(:db)
    Session.delete_all ["updated_at < ?", time]
  end

end