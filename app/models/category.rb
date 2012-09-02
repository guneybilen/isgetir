class Category < ActiveRecord::Base
  has_many :jobs
  default_scope order('categories.name')

  attr_accessor :category_name

end
