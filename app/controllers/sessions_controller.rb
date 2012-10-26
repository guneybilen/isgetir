 class SessionsController < ApplicationController
  #force_ssl

  def create
    if user = User.authenticate(params[:email], params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        session[:user_id] = user.auth_token
      end
      redirect_to root_path, :notice => t('sessions_controller.create.success')
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
