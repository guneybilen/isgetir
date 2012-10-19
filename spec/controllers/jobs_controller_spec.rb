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

end