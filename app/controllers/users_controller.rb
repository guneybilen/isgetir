class UsersController < ApplicationController
  #force_ssl
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  def new
    session[:time_now] = Time.now
    @user = User.new
  end
  def create

  if !Rails.env.test?
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
    #@user = current_user  # correct_user takes care of this line
  end
  def update
    #@user = current_user  # correct_user takes care of this line
    if params[:user][:password].blank?
      @user.errors.add('', t('general.password_cannot_be_blank'))
      render :action => 'edit'
    elsif @user.update_attributes(params[:user])
      redirect_to jobs_path, :notice => t('users_controller.update.success')
    else
      render :action => 'edit'
    end
  end

  private
  def correct_user
    @user = User.find_by_id(params[:id])   # find_by_id returns nil if user with the id not found v.s. find which returns an exception
    redirect_to(root_path) unless !@user.nil? && current_user == @user
  end
end