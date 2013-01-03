class Comment < ActiveRecord::Base

  attr_accessible :name, :lastname, :email, :body
  belongs_to :job
  validates :name, :email, :body, :presence => true
  validates :job_id, :presence => true

end
