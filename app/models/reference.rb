class Reference < ActiveRecord::Base

  belongs_to :job

  attr_accessible  :name, :lastname, :phone, :cell, :email

  validates :job_id, :presence => true

end
