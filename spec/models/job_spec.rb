require 'spec_helper'

describe Job do

  before(:each) do
    @user = Factory(:user1)
    @attr = { :title => "title", :body => 'body', :location => 'location' }
  end
  it "should create a new instance given valid attributes" do
    @user.jobs.create!(@attr)
  end

  describe "user associations" do
    before(:each) do
      @job = @user.jobs.create(@attr)
    end
    it "should have a user attribute" do
      @job.should respond_to(:user)
    end
    it "should have the right associated user" do
      @job.user_id.should == @user.id
      @job.user.should == @user
    end
  end

  describe "validations" do
    it "should require a user id" do
      Job.new(@attr).should_not be_valid
    end
    it "should require nonblank content" do
      @user.jobs.build(:title => " ").should_not be_valid
    end
    it "should require nonblank content" do
      @user.jobs.build(:body => " ").should_not be_valid
    end
    it "should reject long content" do
      @user.jobs.build(:body => "a" * 301).should_not be_valid
    end
  end
end

