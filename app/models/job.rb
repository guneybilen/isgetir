class Job < ActiveRecord::Base
  #default_scope :order => 'created_at DESC'

  validates :title, :presence => true
  validates :body, :presence => true
  validates :body, :length => { :maximum => 300 }
  #validates :category_id, :presence => true

  belongs_to :user
  #has_many :job_categories
  belongs_to :category
  has_many :comments
  has_many :references, :dependent => :destroy
  accepts_nested_attributes_for :references, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  simple_search :title, :body, :location

  scope :created, where("jobs.created_at IS NOT NULL")
  scope :recent, lambda { created.where("jobs.created_at > ?", 1.week.ago.to_date)}
  scope :where_title, lambda { |term| where("jobs.title LIKE ?", "%#{term}%") }
  scope :cat_by_name, joins(:category).order('categories.name')
  scope :cat_by_isim, joins(:category).order('categories.isim')

  # Asagidaki category_by_name ve category_by_isim methodlari yerine :cat_by_name ve :cat_by_id scopelarini kullandim
  # Asagidaki iki method "undefined method 'sub' for ActiveRecord::Relation" hatasini veriyor
  # Hatanin sebebini anladim sanirim: method adlari onune self koymayi unutmusum
  #def self.category_by_name
  #  Job.joins(:category).order('categories.name')
  #end
  #
  #def self.category_by_isim
  #  Job.joins(:category).order('categories.isim')
  #end


  def self.search_by_category(cat_id)
    return Job.where("category_id = ?", cat_id).to_a
  end

  def long_title
    "#{title} - #{published_at}"
  end

  def owned_by?(owner)
    return false unless owner.is_a? User
    # user is defined in sessions_controller
    user == owner
  end

end
