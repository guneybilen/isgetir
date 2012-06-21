class User < ActiveRecord::Base
  has_one :profile
  has_many :jobs, :order => 'published_at DESC, title ASC',
                    :dependent => :nullify
  has_many :replies, :through => :skills, :source => :comments



end
