require 'will_paginate/array'

class UsersController < ApplicationController
  #force_ssl
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]

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
      if is_admin?
        flash[:notice] = t('users_controller.create.success')
        redirect_to new_user_path and return false end
      session[:user_id] = @user.auth_token
      redirect_to jobs_path, :notice => t('users_controller.create.success')
    else
      render :action => 'new'
    end
  end

  def edit
    #@user = current_user  # correct_user takes care of this line
  end

  def admin_edit_user
     if is_admin?
      render 'admin_edit_user'
    end
  end

  def admin_change_password
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    user = {:id => params[:User][:id], :password=>params[:password],
            :password_confirmation=>params[:password_confirmation]}
    @user = User.find_by_id(params[:User][:id])

    if @user.nil?
      flash[:notice] = t('general.choose')
      redirect_to admin_edit_user_path and return false
    end

    if params[:password].blank?
      @user.errors.add('', t('general.password_cannot_be_blank'))
      render 'admin_edit_user'
    end

    if params[:password] != params[:password_confirmation]
      @user.errors.add('', t('activerecord.errors.models.user.attributes.password.confirmation'))
      render 'admin_edit_user'
    elsif @user.update_attributes(user)
      redirect_to user_admin_path, :notice => t('users_controller.update.success')
    else
      render 'admin_edit_user'
    end

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

  def admin_update_user_interface
    #puts "_______________________________________________________ #{params}"
    @user = User.find_by_id(params[:user])
    #p @user
    @jobs = @user.jobs
  end

  def admin_updated_user

    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{params}"

    @user = User.find_by_id(params[:id])
    @job = @user.jobs.find_by_id(params[:job_id])



    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = t('jobs_controller.update.success')
        format.html
        format.json { head :ok }
      else
        format.html { render action: 'admin_update_user_interface' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end


  def index

    if self.is_admin?
      @user = User.paginate(:page => params[:page])
    else
      redirect_to root_path
    end

  end

  def destroy
    if !current_user.nil? && current_user.is_admin?
      #p params
      @user = User.find(params[:users])
      User.destroy(@user)
      if (params[:page].blank?)
        @user = User.paginate(:page => 1)
      else
        @user = User.paginate(:page => params[:page])
        #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        #render :js => "alert('Hello Rails');"
      end


      #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ #{@user}"

        respond_to do |format|
          format.js  # burda destroy.js.erb invoke edilsin istiyorum
        end
      #end
    else
      redirect_to root_path
    end
  end

  def show

  if (params[:page].nil?)
    @user = User.paginate(:page => 1)
  else
    @user = User.paginate(:page => params[:page])
  end

  render 'admin_manage'

  end

  def admin
  end

  def admin_manage
    #puts "_______________________________________________________ #{params}"
    if self.is_admin?
      @user = User.paginate(:page => params[:page])
    else
      redirect_to root_path
    end

    @admin_type = params[:admin]

    #respond_to do |format|
    #  format.html {
        render 'admin_manage'
      #}
      #format.js
    #end

  end

  private
  def correct_user
    @user = User.find_by_id(params[:id])   # find_by_id returns nil if user with the id not found v.s. find which returns an exception
    redirect_to(root_path) unless !@user.nil? && current_user == @user
  end

  def admin_user
    if !current_user.nil?
    redirect_to(root_path) unless current_user.is_admin?
    else
      false
    end
  end
end