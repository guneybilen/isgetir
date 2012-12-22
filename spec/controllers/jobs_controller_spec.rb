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

end