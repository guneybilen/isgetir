require 'spec_helper'

describe JobsController do

  def mock_skill(stubs={})
    (@mock_skill ||= mock_model(Job).as_null_object).tap do |skill|
      skill.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all skills as @skills" do
      Job.stub(:all) { [mock_skill] }
      get :index
      assigns(:jobs).should eq([mock_skill])
    end
  end

  describe "GET show" do
    it "assigns the requested skill as @skill" do
      Job.stub(:find).with("37") { mock_skill }
      get :show, :id => "37"
      assigns(:job).should be(mock_skill)
    end
  end

  describe "GET new" do
    it "assigns a new skill as @skill" do
      Job.stub(:new) { mock_skill }
      get :new
      assigns(:job).should be(mock_skill)
    end
  end

  describe "GET edit" do
    it "assigns the requested skill as @skill" do
      Job.stub(:find).with("37") { mock_skill }
      get :edit, :id => "37"
      assigns(:job).should be(mock_skill)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created skill as @skill" do
        Job.stub(:new).with({'these' => 'params'}) { mock_skill(:save => true) }
        post :create, :job => {'these' => 'params'}
        assigns(:job).should be(mock_skill)
      end

      it "redirects to the created skill" do
        Job.stub(:new) { mock_skill(:save => true) }
        post :create, :job => {}
        response.should redirect_to(skill_url(mock_skill))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved skill as @skill" do
        Job.stub(:new).with({'these' => 'params'}) { mock_skill(:save => false) }
        post :create, :job => {'these' => 'params'}
        assigns(:job).should be(mock_skill)
      end

      it "re-renders the 'new' template" do
        Job.stub(:new) { mock_skill(:save => false) }
        post :create, :job => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested skill" do
        Job.should_receive(:find).with("37") { mock_skill }
        mock_skill.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :job => {'these' => 'params'}
      end

      it "assigns the requested skill as @skill" do
        Job.stub(:find) { mock_skill(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:job).should be(mock_skill)
      end

      it "redirects to the skill" do
        Job.stub(:find) { mock_skill(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(skill_url(mock_skill))
      end
    end

    describe "with invalid params" do
      it "assigns the skill as @skill" do
        Job.stub(:find) { mock_skill(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:job).should be(mock_skill)
      end

      it "re-renders the 'edit' template" do
        Job.stub(:find) { mock_skill(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested skill" do
      Job.should_receive(:find).with("37") { mock_skill }
      mock_skill.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the skills list" do
      Job.stub(:find) { mock_skill }
      delete :destroy, :id => "1"
      response.should redirect_to(skills_url)
    end
  end

end
