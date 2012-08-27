require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = jobs(:makinist)
    @job2 = jobs :terzi
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_template 'index'
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    login_as :lauren
    get :new
    assert_response :success
  end

  test "should create a job as :lauren user" do
    login_as(:lauren)
    assert_difference('Job.count') do
      post :create, :job => { :title => 'Post title',
                              :body => 'Lorem ipsum..' }
    end
    assert_response :redirect
    assert_redirected_to job_path(assigns(:job))
  end

   test "should create another job as :eugene user" do
    login_as :eugene
    assert_difference('Job.count') do
      post :create, :job => { :title => 'Post title',
                              :body => 'Lorem ipsum..' }
    end
    assert_response :redirect
    assert_redirected_to job_path(assigns(:job))
  end

  test "should show job" do
    get :show, id: @job.to_param
    assert_response :success
    assert_response :success
    assert_template 'show'
    assert_not_nil assigns(:job)
    assert assigns(:job).valid?
  end

  test "should get edit" do
    login_as :lauren
    get :edit, id: @job.to_param
    assert_response :success
  end

  test "should update job" do
    login_as(:lauren)
    put :update, id: @job.to_param, job: { :title => 'New Title' }
    assert_redirected_to job_path(assigns(:job))
  end

  test "should update job2" do
    login_as :eugene
    put :update, id: @job2.to_param, job: { :title => 'New Title' }
    assert_redirected_to job_path(assigns(:job))
  end

  test "should destroy job" do
    login_as(:lauren)
    assert_nothing_raised { Job.find(@job.to_param) }
    assert_difference('Job.count', -1) do
      delete :destroy, :id => @job.to_param
    end
    assert_response :redirect
    assert_redirected_to jobs_path
    assert_raise(ActiveRecord::RecordNotFound) { Job.find(@job.to_param) }
  end

  test "should destroy job2" do
    login_as(:eugene)
    assert_nothing_raised { Job.find(@job2.to_param) }
    #puts "##################### " + @job2.to_param
    assert_difference('Job.count', -1) do
      delete :destroy, :id => @job2.to_param
    end
    assert_response :redirect
    assert_redirected_to jobs_path
    assert_raise(ActiveRecord::RecordNotFound) { Job.find(@job2.to_param) }
  end
end

