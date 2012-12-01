require 'spec_helper'
#require 'controllers/sessions_controller_spec'
#require 'requests/users_spec'
#require "sessions_controller"

describe UsersController do
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector('title', :content => 'isgetir.com')
    end

    it "should have the right title" do
        get 'new'
        response.should have_selector('h2', :content => I18n.t('general.new_user'))
    end

  end

  describe "POST 'create'" do

    before :each do
      @attr = { :email => "",
                 :password => "",
                 :password_confirmation => ""
               }
    end

    it "should not create a user" do
      lambda do
        post :create, :user => @attr
      end.should_not change(User, :count)
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector('title', :content => 'isgetir.com')
    end

    it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template('new')
    end

    describe "success" do

      before :each do
        @attr = { :email => "user@example.com",
                   :password => "foobar",
                   :password_confirmation => "foobar"
               }
      end

      it "should create a new user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should have the right title" do
        get 'new'
        response.should have_selector('title', :content => 'isgetir.com')
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(jobs_path)
      end

      it "should have the right flash message" do
        post :create, :user => @attr
        flash[:notice].should == I18n.t('users_controller.create.success')
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_logged_in
      end

    end

  end

  describe "GET 'edit'"  do

    before :each do
      @user = Factory(:user3)
      test_sign_in(@user)
    end

    it 'should be successful' do
      #puts controller.send(:current_user).nil?
      #controller.should be_logged_in
      #p @user
      get :edit, :id => @user
      response.should be_success # "redirect does not means success"
      #puts response.body.inspect
      #response.should be_redirect
    end

    it "should have the right title" do
      get :edit, :id => @user
      puts response.headers['Location']
      response.should have_selector("title", :content => "isgetir.com")
    end

  end
end
