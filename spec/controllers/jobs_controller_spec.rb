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
      @user = FactoryGirl.create(:user1)
      @job = FactoryGirl.create(:job, :user=>@user)
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
      @user = test_sign_in(FactoryGirl.create(:user1))
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
        @user = FactoryGirl.create(:user1)
        wrong_user = FactoryGirl.create(:user1, :email => FactoryGirl.generate(:email))
        test_sign_in(wrong_user)
        @job = FactoryGirl.create(:job, :user => @user)
      end
      it "should deny access" do
        delete :destroy, :id => @job
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do
      before(:each) do
        @user = FactoryGirl.create(:user1)
        test_sign_in(@user)
        @job = FactoryGirl.create(:job, :user => @user)
      end
      it "should destroy the job" do
        lambda do
          delete :destroy, :id => @job
        end.should change(Job, :count).by(-1)
      end
    end
  end


  describe "from a translation from the rspec testing book" do

    before(:each) do
      @some_user = FactoryGirl.create(:user1)
      test_sign_in(@some_user)
      @job = FactoryGirl.create(:job1, :user => @some_user)
      #p @job
    end

    # it yerine context kullandin mi asagidaki kodlarda hata veriyor

    it "rspec testing book pg 200 or 201" do
      @job.stub(:update_attributes).and_return(true)
      Job.should_receive(:find).with("1").and_return(@job)
      Job.find("1")
      put :update, :id => 1
    end

     it "another rspec book example from pg 200" do
       Job.stub(:find).and_return(@job)
       @job.should_receive(:update_attributes).and_return(true)
       @job.update_attributes(:title => "Lorem ipsum", :body => "Lorem ipsum")
     end

     it "rspec book example pg 201" do
       job = double('job', :a_method_created_here =>"guney", :another_method_created_here =>"bilen")
       job.a_method_created_here == "guney"
       response.should be_success
       job.another_method_created_here == "bilen"
       response.should be_success
     end

      it "rspec book pg 202" do
        j = Job.new
        j.stub(:some_method) do |value|
          if value == 18
            "young"
          else
            "old"
          end
        end

        # sadece .once ve .twice rakam-isim olarak

        #j.should_receive(:some_method).exactly(2).times    # pg 203  .exactly ve .at_most ayni anda calisabiliyor
        # ama .once .twice ve .at_least sadece kendileri olmali yani yalniz olmalilar calismalari icin

        # j.should_receive(:some_method).at_most(2).times    # pg 204

        # j.should_receive(:some_method).at_least(2).times   # pg 204  at least'den once
        # baska .exactly, .once veya benzeri gelmemesi lazim

        # j.should_receive(:some_method).with(18).once # Internet'den j.some_method call'dan once gelmeli
        # j.should_receive(:some_method).with(40).once # .once'dan once baska .exactly, .once veya benzeri gelmemesi lazim

        # j.should_receive(:some_method).twice      # pg 204 -twice not working - calisiyormus ama kendisinden once
        # baska .exactly, .once veya benzeri gelmemesi lazim

        # j.should_receive(:some_method).with(instance_of(Fixnum)).exactly(2).times # pg 205 .with 1 den cok argument
        # alabiliyor bu statement j.some_method call'dan once gelmeli aksi takdirde calismiyor. bu statement'dan once
        # baska .exactly, .at_most ve benzerleri gelmemesi lazim.

        # j.should_receive(:some_method).with(anything()) # pg 206 hash de var:
        # .with(hash_including('e' => '123', 'm'=>'999')) ve .with(hash_not_including(...))
        # you can use regexp: .with(/\d+/)
        # j.should_receive(:some_method).with(any_args()) # pg 206 no_args() da var

        j.should_receive(:some_method).with(greater_than 10)  # see below class GreaterThanMatcher - pg 208'den
        j.some_method(18) == "young"
        j.some_method(40) == "old"

        j.should_not_receive(:another_method)  # pg 204


      end

      it "rspec book pg 203" do
        j = Job.new
        j.stub_chain(:a_method, :another_method, :some_method).and_return(j)
        j.a_method.another_method.some_method == j
      end

     it "rspec book pg 209" do
       Job.should_receive(:find_by_id).and_return(nil)  # bu line bu linde'dan - Job.find_by_id(10000) - once gelmeli
       Job.find_by_id(10000)
     end

    it "rspec book pg 209" do
      Job.should_receive(:find_by_id).exactly(3).times.and_return(nil,nil,30000)  # .times olmasada calisiyor
      # bir yukardaki line bu linde'dan - Job.find_by_id(10000) - once gelmeli
      Job.find_by_id(10000)
      Job.find_by_id(20000)
      j = Job.find_by_id(30000)
      j.should equal(30000)     # equal ayni zamanda object identity check icinde kullaniliyor .should ==() ise value check icin
      j.should_not == 40000
    end

    it "rspec book pg 210" do
      begin
        Job.should_receive(:find).exactly(2).times.and_raise("ActiveRecord::RecordNotFound")  # .times olmasada calisiyor
        # bir yukardaki line bu linde'dan - Job.find_by_id(10000) - once gelmeli
        Job.find 100000
        # Note begin de once an error is encountered the progress continues from rescue
      rescue
        begin
          Job.find(20000)
        rescue
          puts "Rescued ActiveRecord::RecordNotFound"
        end
      end
    end

    it "rspec book pg 178" do
      expect {Job.find(500)}.to raise_error
    end

  end

end


# class GreaterThanMatcher pg 208'den
class GreaterThanMatcher
  def initialize(expected)
    @expected = expected
  end

  def description
    "a number greater than #{@expected}"
  end

  def ==(actual)
    actual > @expected
  end
end

def greater_than(floor)
  GreaterThanMatcher.new(floor)
end