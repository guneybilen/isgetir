class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
# Returns the currently logged in user or nil if there isn't one
  def current_user
    if cookies[:auth_token]
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token])
    elsif session[:user_id]
      @current_user ||= User.find_by_auth_token!(session[:user_id])
    else
      return
    end

    #@current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
    #return unless session[:user_id]
    #@current_user ||= User.find_by_id(session[:user_id])
  end

# Make current_user available in templates as a helper
  helper_method :current_user
# Filter method to enforce a login requirement
# Apply as a before_filter on any controller you want to protect
  def authenticate
    logged_in? ? true : access_denied
  end
# Predicate method to test for a logged in user
  def logged_in?
    current_user.is_a? User
  end
# Make logged_in? available in templates as a helper
  helper_method :logged_in?
  def access_denied
    redirect_to login_path, :notice => t('application.access_denied.log_in_to_continue') and return false
  end
end
