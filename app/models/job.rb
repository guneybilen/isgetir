class Job < ActiveRecord::Base
  validates :title, :presence => true
  validates :body, :presence => true

  belongs_to :user
  #has_many :job_categories
  belongs_to :category
  has_many :comments
  has_many :references, :dependent => :destroy
  accepts_nested_attributes_for :references, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  scope :created, where("jobs.created_at IS NOT NULL")
  scope :recent, lambda { created.where("jobs.created_at > ?", 1.week.ago.to_date)}
  scope :where_title, lambda { |term| where("jobs.title LIKE ?", "%#{term}%") }

  def long_title
    "#{title} - #{published_at}"
  end
end
