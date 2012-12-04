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

  describe "PUT 'update'" do
    before(:each) do
      @user = Factory(:user2)
      test_sign_in(@user)
    end

    describe "failure" do
      before(:each) do
        @attr = { :email => "", :name => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector("title", :content => "isgetir.com")
      end
    end

    describe "success" do
      before(:each) do
        @attr = {:email => "bilen@bilen.com",
                 :password => "barbaz", :password_confirmation => "barbaz" }
      end
      it "should change the user's attributes" do
        #p @user
        before_update_user = @user

        put :update, :id => @user, :user => @attr

        updated_record = assigns[:user]

        #p before_update_user
        #p updated_record

        # http://stackoverflow.com/questions/10626831/rspec-doesnt-reload-changed-password-attribute-why
        # ogrendigime gore password attribute virtual oldugu icin db'ye save edilmediginden
        # asagidaki test fails
        # @user.password.should == @attr[:password]

        #@user.reload  # assigns[:user] zaten gets the updated record @user.reload ypatinmi iki tane
        # updated ayni record oluyor elimizde

        before_update_user.hashed_password.should_not == updated_record.hashed_password
        @user.email.should == @attr[:email]
      end

      it "should redirect to the root path" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(jobs_path)
      end
      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:notice].should == I18n.t('users_controller.update.success')
      end
    end
  end

  describe "authentication of edit/update pages" do
    before(:each) do
      @user = Factory(:user3)
    end
    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(login_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(login_path)
      end
    end

    describe "for signed-in users" do
      before(:each) do
        wrong_user = Factory(:user3, :email => "user@example.net")
        test_sign_in(wrong_user)
      end
      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(root_path)
      end
      it "should require matching users for 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(root_path)
      end
    end
  end

  describe "GET 'index'" do
    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        response.should redirect_to(login_path)
        flash[:notice].should == I18n.t('application_controller.access_denied.log_in_to_continue')
      end
    end

    it "should show the index to the admin" do
      @admin=Factory(:user4)
      test_sign_in(@admin)
      get :index
      response.should render_template('users')

=begin

      response.should render_template('/users')  oldumu but hatayi veriyor:

      1) UsersController GET 'index' should show the index to the admin
     Failure/Error: response.should render_template('/users/index')
       expecting <"/users/index"> but rendering with <"users/index, layouts/_flash, layouts/application">
     # ./spec/controllers/users_controller_spec.rb:224:in `block (3 levels) in <top (required)>'
=end


    end

=begin
    describe "for signed-in users" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        second = Factory(:user, :email => "another@example.com")
        third = Factory(:user, :email => "another@example.net")
        @users = [@user, second, third]
      end
      it "should be successful" do
        get :index
        response.should be_success
      end
      it "should have the right title" do
        get :index
        response.should have_selector("title", :content => "All users")
      end
      it "should have an element for each user" do
        get :index
        @users.each do |user|
          response.should have_selector("li", :content => user.name)
        end
      end
  end
=end
    it "should have the right title" do
      @admin=Factory(:user4)
      test_sign_in(@admin)
      get :index
      response.should have_selector("title", :content => "isgetir.com")
    end
  end
end


