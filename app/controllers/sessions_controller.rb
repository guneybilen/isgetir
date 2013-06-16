 class SessionsController < ApplicationController
  #force_ssl

   #include SessionsHelper

   before_filter  :store_location

  def create
    #puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&#{params[:email]}"
    if user = User.authenticate(params[:email], params[:password])
    admin = Admin.authenticate(params[:email], params[:password])
    #if user = User.authenticate(@email, @password)
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        session[:user_id] = user.auth_token
      end
      flash[:notice] = t('sessions_controller.create.success')
      # puts "############################################# #{session[:return_to]}"
      if admin
        p admin
        redirect_to user_admin_path and return false
      end
      #puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    #{params[:category_id]}"

      redirect_back_or root_path
    else
      flash.now[:alert] = t('sessions_controller.create.failure')
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    #reset_session
    Session.check_date
    #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$#{user.auth_token}"
    #ssn = Session.find_by_session_id(session[:user_id])
    #ssn.destroy
    #if params{:category_id} != "0"  && params[:category_id]!= ""
    #  redirect_to search_by_cat_id_path(:locale => 'tr',:category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction],:keyword => params[:keyword], :page => params[:page]), :notice => t('sessions_controller.destroy.success')
    #else
    #  redirect_to root_path(:locale => 'tr',:category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction],:keyword => params[:keyword], :page => params[:page]), :notice => t('sessions_controller.destroy.success')
    #
    #end

    redirect_back_or root_path
    reset_session
    flash[:notice] = t('sessions_controller.destroy.success')
  end


end
