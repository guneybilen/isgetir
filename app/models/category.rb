class Category < ActiveRecord::Base
  has_many :job_categories
  has_many :jobs, :through => :job_categories
end
