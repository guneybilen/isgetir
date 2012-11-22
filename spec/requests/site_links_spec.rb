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

    describe "when not signed in" do
      it "should have a login link" do
        visit root_path
        response.should have_selector("a", :href => login_path,
                                            :content => I18n.t('general.menu.login'))
      end
    end

    describe "when signed in" do

      before :each do
        @user = Factory(:user1)
        visit login_path
        # asagida fill_in'lerin yanindaki veri text field id adi
        fill_in :email,     :with => @user.email
        fill_in :password,  :with => @user.password
      # fill_in I18n.t('general.password') => Could not find field "Şifre" hatasi veriyor
        click_button
      end

      it "should have a logout link" do
        visit root_path
        response.should have_selector("a", :href => logout_path,
                                            :content => I18n.t('general.menu.logout'))
      end

      it "should have a new job link" do
        visit root_path
        response.should have_selector("a", :href => new_job_path,
                                            :content => I18n.t('general.menu.new_job'))
      end

    end

  end
end

