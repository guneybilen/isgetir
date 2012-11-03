require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @attr = {:email => "user@example.com", :password => "guney", :password_confirmation => "guney"}
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a email" do
    no_email_user = User.new(@attr.merge(:email => ''))
    no_email_user.should_not be_valid
  end

  it "should require a password" do
    no_password_user = User.new(@attr.merge(:password => ''))
    no_password_user.should_not be_valid
  end

  it "should require a password confirmation" do
    no_password_confirmation_user = User.new(@attr.merge(:password_confirmation => ''))
    no_password_confirmation_user.should_not be_valid
  end


   it "should reject a password that is shorter than 5 chars" do
    no_password_user = User.new(@attr.merge(:password => 'aaaa'))
    no_password_user.should_not be_valid
   end

  it "should reject a password that is longer than 20 chars" do
    no_password_user = User.new(@attr.merge(:password => 'a' * 21))
    no_password_user.should_not be_valid
  end

  it "should require matching password confirmation" do
    User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
  end
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an hashed_password attribute" do
      @user.should respond_to(:hashed_password)
    end

    it "should set the hashed_password" do
      @user.hashed_password.should_not be_blank
    end
  end
end
