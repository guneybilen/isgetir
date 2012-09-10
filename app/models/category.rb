
class Category < ActiveRecord::Base
  has_many :jobs
  #scope  :order, lambda { |order|
  #  {
  #    :order => case order
  #    when "name"  "name asc"
  #    when "isim"  "isim asc"
  #    end
  #  }
  #}

  #scope :isim, order("isim asc")
  #scope :name, order("name asc")

  attr_accessor :category_name

  #simple_search :category, :isim
end
