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

    describe "authenticated? method" do
      it "should be true if the passwords match" do
        @user.authenticated?(@attr[:password]).should be_true
      end

      it "should be false if the passwords do not match" do
        @user.authenticated?("invalid").should be_false
      end
    end

    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end

     it "should respond to is_admin db attribute in User model" do
       @user.should respond_to(:is_admin)
     end

    it "should not be an admin by default" do
       @user.should_not be_is_admin
    end

     it "should be convertible to an admin" do
       @user.toggle!(:is_admin)
       @user.should be_is_admin
    end
  end

  describe "jobs associations" do
    before :each do
      @user = User.create(@attr)
      @mp1 = Factory(:job, :user => @user, :created_at => 1.day.ago)
      @mp2 = Factory(:job, :user => @user, :created_at => 1.hour.ago)
    end

    it "should have a jobs attribute" do
      @user.should respond_to(:jobs)
    end

    it "should have the right jobs in the right order" do
      @user.jobs.should == [@mp2, @mp1]
    end

    it "should destroy associated jobs" do
      @user.destroy

      [@mp1, @mp2].each do |job|
        Job.find_by_id(job.id).user_id.should be_nil
      end
    end
  end
end
