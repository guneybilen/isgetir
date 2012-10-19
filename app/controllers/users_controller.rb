class UsersController < ApplicationController
  #force_ssl
  before_filter :authenticate, :only => [:edit, :update]

  def new
    session[:time_now] = Time.now
    @user = User.new
  end
  def create

    @time_too_fast = ''

    time_later # defined in application controller
    hidden_field  # defined in application controller

    if !@hidden.blank?
      flash[:notice] = t('general.hidden_text_field_change')
      @user = User.new
      render :action => 'new' and return
    end

    if !@time_too_fast.blank?
      flash[:notice] = t('general.too_fast')
      @user = User.new
      render :action => 'new' and return
    end

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