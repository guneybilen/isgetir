class Job < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true

  belongs_to :user
  has_many :job_categories
  has_many :categories, :through => :JobCategory
  has_many :comments
  has_many :references, :dependent => :destroy
  accepts_nested_attributes_for :references, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  def long_title
    "#{title} - #{published_at}"
  end
end
