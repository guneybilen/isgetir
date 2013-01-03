require 'spec_helper'

describe CommentsController do

  describe "should redirect to log in"

  before :each do
    @user = Factory(:user1)
    @job = Factory(:job, :user => @user)
  end
   it "should deny access to 'destroy'" do
     delete :destroy, {:job_id => @job, :id => 1}
     response.should redirect_to(login_path)
   end

end
