require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "isgetir.com")
    end
  end

  describe "POST 'create'" do

    describe "invalid signin" do

      before :each do
        @attr = {:email => "email@example.com", :password => "invalid"}
      end

      it "should re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should have the right title" do
        post :create, :session => @attr
        response.should have_selector("title", :content => "isgetir.com")
      end

       it "should have a flash.now message" do
        post :create, :session => @attr
        flash.now[:alert].should == I18n.t('sessions_controller.create.failure')
      end
    end

    describe "with valid email and password" do

      before :each do

        #begin
        #@user = Factory(:user3)
        #   rescue => invalid
        #    puts invalid.errors.full_messages
        #  end
        # @attr = {:email => @user.email, :password => @user.password}
        # burda  @attr kullandin mi ve asagida :session => @attr yaptin mi test hata veriyor.
        #  :session => @attr yerine post :create, :email => @user.email, :password => @user.password
        #  yaptin mi sessions_controller'daki Session#create'deki User.authenticate calisiyor ve hata vermiyor.
      @user = Factory(:user3)
      end

      it "should redirect to the root_path" do
        post :create, :email => @user.email, :password => @user.password
        #current_url.should == root_url  not an rspec convention as much as I learned
        puts response.body
        response.should redirect_to(jobs_path)
        response.header["Location"].should eq("http://test.host/jobs")
        puts "\nresponse header is: " + response.header.to_s
        puts "\n#{@attr.to_s}"
        puts "\n#{assigns(:session).nil?}" # true veriyor cunku session model diye bir sey yok sanirim
       end

      it "should sign the user in" do
        post :create, :email => @user.email, :password => @user.password
        controller.send(:current_user).should == @user
        controller.should be_logged_in
      end
    end

    describe "signout functionality" do

      before :each do
        @user = Factory(:user1)
        @attr = {:email => @user.email, :password => @user.password}
        post :create, :session => @attr
      end

      it "should sign the user out" do
        delete :destroy
        controller.should_not be_logged_in
        response.should redirect_to(root_path)
      end
    end

  end
end
