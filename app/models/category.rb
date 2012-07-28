class Category < ActiveRecord::Base
  has_many :jobs
  default_scope order('categories.name')
end
