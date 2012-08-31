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
    redirect_to root_path, :notice => t('sessions_controller.destroy.success')
  end
end
