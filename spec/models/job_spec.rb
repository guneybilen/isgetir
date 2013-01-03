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

    describe "comments creation" do
      before :each do
        #test_sign_in(@user)

        begin
          @y = Factory(:job1, :user => @user)
          @z = @y.comments.build(name: "guney bilen", email: "g@bilen.com", body: "harika bir is").should be_valid
        rescue ActiveRecord::RecordInvalid => invalid
          puts invalid.record.errors.full_messages
        end

      end

      it "should be able to save the built comment" do
        @z.should == true
      end

      it "should create a new comment" do
        t = @y.comments.create!(name: "guney bilen", email: "g@bilen.com", body: "harika bir is")
        @y.comments.should include(t)
      end

      it "should create a new reference" do
        @y.references.create!(name: "hasan bilen", email: "h@bilen.com").should be_valid
      end

    end
  end
end

