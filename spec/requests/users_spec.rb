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
end

