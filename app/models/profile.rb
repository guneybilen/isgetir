class Profile < ActiveRecord::Base
  attr_accessible  # none icin hicbir symbol vermesen yetiyor
  belongs_to :user
end
