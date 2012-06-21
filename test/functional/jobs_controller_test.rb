require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  setup do
    @job = skills(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create skill" do
    assert_difference('Skill.count') do
      post :create, job: @job.attributes
    end

    assert_redirected_to skill_path(assigns(:job))
  end

  test "should show skill" do
    get :show, id: @job.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @job.to_param
    assert_response :success
  end

  test "should update skill" do
    put :update, id: @job.to_param, job: @job.attributes
    assert_redirected_to skill_path(assigns(:job))
  end

  test "should destroy skill" do
    assert_difference('Skill.count', -1) do
      delete :destroy, id: @job.to_param
    end

    assert_redirected_to skills_path
  end
end
