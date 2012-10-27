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

  it "should reject a password that is longer than 20 chars" do
    no_password_user = User.new(@attr.merge(:password => 'a' * 21))
    no_password_user.should_not be_valid
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

end
