require 'spec_helper'

describe CommentsController do

  context "should redirect to log in" do

    before :each do
      @user = Factory(:user1)
      @job = Factory(:job, :user => @user)
    end

    before { puts "before" }
    after { puts "after"}

    it "should deny access to 'destroy' when not signed in" do
      delete :destroy, {:job_id => @job, :id => 1}
      response.should redirect_to(login_path)
    end
  end
end
