require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit new_user_path
          fill_in I18n.t('general.email'),                    :with => ""
          fill_in I18n.t('general.password'),                 :with => ""
          fill_in I18n.t('general.password_confirmation'),  :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("span.required_mark")
        end.should_not change(User, :count)
      end
    end

    describe "success" do

      it "should make a new user" do
        lambda do
          visit new_user_path
          fill_in I18n.t('general.email'),                    :with => "user@example.com"
          fill_in I18n.t('general.password'),                 :with => "foobar"
          fill_in I18n.t('general.password_confirmation'),  :with => "foobar"
          click_button
          response.should have_selector("div#notice", :content => I18n.t('users_controller.create.success'))
          response.should render_template('/')
        end.should change(User, :count).by(1)
      end
    end

  end

 describe "sign in/out" do
   describe 'failure' do

      it "should not sign a user in" do
          visit login_path
          fill_in :email,                    :with => ""
          fill_in :password,                 :with => ""
          click_button
          response.should have_selector("div#notice", :content => I18n.t('sessions_controller.create.failure'))
      end
   end



    describe "success" do

      it "should sign a user in and out" do
          user = Factory(:user1)
          visit login_path
          fill_in :email,                    :with => user.email
          fill_in :password,                 :with => user.password
          click_button
          controller.should be_logged_in

          #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          #!!!                                                                                   !!!
          #!!!   Notice burda: click_link I18n.t('general.menu.logout') yani                  !!!
          #!!!   click_link olmasi lazim NOT click_button benim kodumda                          !!!
          #!!!                                                                                   !!!
          #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

          click_link I18n.t('general.menu.logout')
          controller.should_not be_logged_in
          response.should have_selector("div#notice", :content => I18n.t('sessions_controller.destroy.success'))
      end
    end
 end
end




