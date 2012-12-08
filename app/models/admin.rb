require "digest"

class Admin < ActiveRecord::Base


    attr_accessible :email, :password, :password_confirmation
    attr_accessor :password, :password_confirmation

    before_create { generate_token(:auth_token) }


    validates :email, :uniqueness => {:case_sensitive => false},
              :length => { :within => 5..50 },
              :format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }

    validates :password, :confirmation => true,
              :length => { :within => 5..20 },
              :presence => true,
              :if => :password_required?

     validates :password_confirmation,
              :length => { :within => 5..20 },
              :presence => true,
              :if => :password_required?

    before_save :encrypt_password

    def self.authenticate(email, password)
      admin_user = Admin.find_by_email(email)
      return admin_user if admin_user && admin_user.authenticated?(password)
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
    def encrypt_password
      self.salt = make_salt if new_record?
      self.hashed_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def password_required?
      hashed_password.blank? || password.present?
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end

