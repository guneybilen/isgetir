require "digest"

class User < ActiveRecord::Base

  attr_accessible :email, :password
  attr_accessor :password

  before_create { generate_token(:auth_token) }

  has_one :profile
  has_many :jobs, :order => 'created_at DESC, title ASC',
           :dependent => :nullify
  #has_many :replies, :through => :skills, :source => :comments


  validates :email, :uniqueness => true,
            :length => { :within => 5..50 },
            :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

  validates :password, :confirmation => true,
            :length => { :within => 4..20 },
            :presence => true,
            :if => :password_required?

  before_save :encrypt_new_password
  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end
  def authenticated?(password)
    self.hashed_password == encrypt(password)
  end
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    Notifier.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  protected
  def encrypt_new_password
    return if password.blank?
    self.hashed_password = encrypt(password)
  end
  def password_required?
    hashed_password.blank? || password.present?
  end
  def encrypt(string)
    Digest::SHA1.hexdigest(string)
  end


end
