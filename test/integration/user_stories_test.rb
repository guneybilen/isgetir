require 'test_helper'
class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :all
  test "should login user and redirect" do
    get login_path
    assert_response :success
    assert_template 'new'
    post session_path, :email => 'lauren@example.com', :password => 'secret'
    assert_response :redirect
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_template 'index'
    assert session[:user_id]
  end

  test "should logout user and redirect" do
    get logout_path
    assert_response :redirect
    assert_redirected_to root_path
    assert_nil session[:user]
    follow_redirect!
    assert_template 'index'
  end

  test "should login create a job and logout" do
# Login
    get login_path
    assert_response :success
    assert_template 'new'
    post session_path, :email => 'lauren@example.com', :password => 'secret'
    assert_response :redirect
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_template 'index'
    assert session[:user_id]

# Create a New Job
    get new_job_path
    assert_response :success
    assert_template 'new'
    post jobs_path, :job => {:title => 'Integration Tests',
                             :body => 'Lorem Ipsum..'}
    assert assigns(:job).valid?
    assert_response :redirect
    assert_redirected_to job_path(assigns(:job))
    follow_redirect!
    assert_response :success
    assert_template 'show'
# Logout
    get logout_path
    assert_response :redirect
    assert_redirected_to root_path
    assert_nil session[:user]
    follow_redirect!
    assert_template 'index'
  end

  test "creating a job" do
    lauren = registered_user
    lauren.logs_in 'lauren@example.com', 'secret'
    lauren.creates_job :title => 'Integration tests', :body => 'Lorem Ipsum...'
    lauren.logs_out
  end

  test "multiple users creating a job" do
    eugene = registered_user
    lauren = registered_user
    eugene.logs_in 'eugene@example.com', 'secret'
    lauren.logs_in 'lauren@example.com', 'secret'
    eugene.creates_job :title => 'Integration Tests', :body => 'Lorem Ipsum...'
    lauren.creates_job :title => 'Open Session', :body => 'Lorem Ipsum...'
    eugene.logs_out
    lauren.logs_out
  end

  private
  def registered_user
    open_session do |user|
      def user.logs_in(email, password)
        get login_path
        assert_response :success
        assert_template 'new'
        post session_path, :email => email, :password => password
        assert_response :redirect
        assert_redirected_to root_path
        follow_redirect!
        assert_response :success
        assert_template 'index'
        assert session[:user_id]
      end

      def user.logs_out
        get logout_path
        assert_response :redirect
        assert_redirected_to root_path
        assert_nil session[:user]
        follow_redirect!
        assert_template 'index'
      end

      def user.creates_job(job_hash)
        get new_job_path
        assert_response :success
        assert_template 'new'
        post jobs_path, :job => job_hash
        assert assigns(:job).valid?
        assert_response :redirect
        assert_redirected_to job_path(assigns(:job))
        follow_redirect!
        assert_response :success
        assert_template 'show'
      end
    end
  end
end
