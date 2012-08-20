class SessionsController < ApplicationController
  def create
    if user = User.authenticate(params[:email], params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        session[:user_id] = user.auth_token
      end
      redirect_to root_path, :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid login/password combination"
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
  end
end
