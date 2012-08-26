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

  test "should login create article and logout" do
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

# Create New Article
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
end