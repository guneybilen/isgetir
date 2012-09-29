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
      response.should have_selector('title', :content => @title + '  | Ana Liste')
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

end