class Reference < ActiveRecord::Base

  attr_accessible :name, :lastname, :phone, :cell, :email

  belongs_to :job
end
