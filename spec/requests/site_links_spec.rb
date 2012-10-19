require 'spec_helper'

describe "site_links" do
  describe "GET links" do
    it "should be successful" do
      get '/'
      response.should have_selector(:title, :content => "isgetir.com")
    end

    it "should be successful" do
      get new_user_path   # new_user_path'in altini cizdigine bakma test geciyor
      response.should have_selector(:title, :content => "isgetir.com")
    end
  end
end

