require 'spec_helper'


describe JobsController do
  render_views

  before(:each) do
    #@job = Job.create(:title =>'Programlama', :body=>'java programcisi')
    @title = "isgetir.com"
  end

  describe "GET 'index'"
  it "should be successful" do
    get 'index'
    response.should be_success
  end

  it "should be have the right title" do
    get 'index'
    response.should have_selector('title', :content => @title)
  end

  it "should be have the right title" do
    get 'index'
    response.should have_selector('title', :content => @title + ' | Ana Liste')
    # | isaretinin saginda ve solunda exactly 1 space olmali as in
    # application_helper's title method otherwise the example ends up as failure
  end

=begin
   describe "GET 'new'"
    it "should be successful" do
      get 'new'
      response.should be_success
    end

   describe "GET 'show'"
    it "should be successful" do
      get 'show', :id => @job.id
      response.should render_template('jobs/show')
    end

=end

  describe "GET 'show'" do
    #let(:user) { Factory(:user1) }

    before :each do
      @user = Factory(:user1)
      @job = Factory(:job, :user=>@user)
    end


    it "should be successful" do
      get 'show', :id => @job
      response.should be_success
    end

    it "should find the right user" do
      get 'show', :id => @job
      assigns(:job).should == @job
    end

    it "should have h2 tag" do
      get :show, :id => @job
      response.should have_selector('h2', :content => I18n.t('general.comments'))
    end

    it "should have the div with class 'vr''" do
      get :show, :id => @job
      response.should have_selector('div', :class => 'vr')
    end

    it "should have an image" do
      get :show, :id => @job
      response.should have_selector('div>img')
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(login_path)
    end
    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(login_path)
    end
  end
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user1))
    end

    describe "failure" do
      before(:each) do
        @attr = { :body => "" }
      end
      it "should not create a job" do

        lambda do
          post :create, :job => @attr
        end.should_not change(Job, :count)
      end
      it "should render the new page" do
        post :create, :job => @attr
        response.should render_template('jobs/new')
      end

      describe "success" do
        before(:each) do
          @attr = { :title => "Lorem ipsum", :body => "Lorem ipsum" }
        end
        it "should create a job" do
          lambda do
            post :create, :job => @attr
          end.should change(Job, :count).by(1)
        end
        it "should redirect to the job page" do
          post :create, :job => @attr
          response.should redirect_to(assigns[:job])
        end
        it "should have a flash message" do
          post :create, :job => @attr
          flash[:notice].should == I18n.t('jobs_controller.create.success')
        end
      end
    end
  end

  describe "DELETE 'destroy'" do
    describe "for an unauthorized user" do
      before(:each) do
        @user = Factory(:user1)
        wrong_user = Factory(:user1, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @job = Factory(:job, :user => @user)
      end
      it "should deny access" do
        delete :destroy, :id => @job
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do
      before(:each) do
        @user = Factory(:user1)
        test_sign_in(@user)
        @job = Factory(:job, :user => @user)
      end
      it "should destroy the job" do
        lambda do
          delete :destroy, :id => @job
        end.should change(Job, :count).by(-1)
      end
    end
  end
end
