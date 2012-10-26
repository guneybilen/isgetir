
class Category < ActiveRecord::Base
  attr_accessible  # none icin hicbir symbol vermesen yetiyor

  has_many :jobs
  #scope  :order, lambda { |order|    ise yaramiyor
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
