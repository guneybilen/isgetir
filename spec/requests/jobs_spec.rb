require 'spec_helper'

describe "Jobs" do
  before(:each) do
    user = Factory(:user1)
    visit login_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end


  describe "creation" do
    describe "failure" do
      it "should not make a new job" do
        lambda do
          visit new_job_path
          fill_in :job_body, :with => ""
          click_button
          response.should render_template('jobs/new')
          response.should have_selector("div#notice")
        end.should_not change(Job, :count)
      end
    end

    describe "success" do
      it "should make a new job" do
        title = "Lorem ipsum"
        body = "Lorem ipsum dolor sit amet"
        lambda do
          visit new_job_path
          fill_in :job_title, :with => title
          fill_in :job_body, :with => body
          click_button
          response.should have_selector("div#notice", :content => I18n.t('jobs_controller.create.success'))
        end.should change(Job, :count).by(1)
      end
    end
end
end