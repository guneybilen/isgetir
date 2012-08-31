class UsersController < ApplicationController
  #force_ssl
  before_filter :authenticate, :only => [:edit, :update]

  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.auth_token
      redirect_to jobs_path, :notice => t('users_controller.create.success')
    else
      render :action => 'new'
    end
  end
  def edit
    @user = current_user
  end
  def update
    @user = current_user
    if params[:user][:password].blank?
      @user.errors.add('', t('general.password_cannot_be_blank'))
      render :action => 'edit'
    elsif @user.update_attributes(params[:user])
      redirect_to jobs_path, :notice => t('users_controller.update.success')
    else
      render :action => 'edit'
    end
  end
end