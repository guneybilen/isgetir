class Comment < ActiveRecord::Base
  belongs_to :job
  validates :name, :email, :body, :presence => true

end
