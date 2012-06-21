class Job < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true

  belongs_to :user
  has_many :job_categories
  has_many :categories, :through => :JobCategory
  has_many :comments

  def long_title
    "#{title} - #{published_at}"
  end
end
