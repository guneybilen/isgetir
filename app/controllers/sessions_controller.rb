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
      puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    #{params[:category_id]}"

      if params[:category_id].to_i > 0
        #redirect_to search_by_cat_id_path
        redirect_back_or jobs_path
      else
        redirect_back_or jobs_path
      end
      #redirect_to jobs_path
    else
      flash.now[:alert] = t('sessions_controller.create.failure')
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    reset_session
    Session.check_date
    #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$#{user.auth_token}"
    #ssn = Session.find_by_session_id(session[:user_id])
    #ssn.destroy
    redirect_to root_path, :notice => t('sessions_controller.destroy.success')
  end

end
