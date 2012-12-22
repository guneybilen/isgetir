class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale #, :set_charset

  #helper_method :search_autocomplete

=begin
  set_charset method'a ihtiyacim var mi bilmiyorum
  su adresten aldim: http://www.ruby-forum.com/topic/103419

  def set_charset
    headers["Content-Type"] = "text/html; charset=utf-8"
  end
=end


=begin

  # By default all helpers are available in the views but to include *_helper methods
  # in the controllers you need to explicitly specify them as in here:
  include ApplicationHelper
  include CommentsHelper
  include JobsHelper
  include PasswordResetsHelper
  include SessionsHelper
  include UsersHelper

=end


  include SessionsHelper

  if Rails.env.production?
    rescue_from Exception, :with => :server_error
    def server_error(exception)
      @error = "ERROR"
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ #{@error}"
      ExceptionNotifier::Notifier.exception_notification(request.env, exception).deliver

    end
  end

  protected

  def time_later
    @time_later = Time.now
    if ((session[:time_now] + 5) >= @time_later)
      @time_too_fast = t('general.too_fast')
    end
  end

  def hidden_field
    #p params[:hidden]
    if (params[:hidden] != '' && params[:hidden] != nil)
      p params[:hidden]
      @hidden = t('general.hidden_text_field_change')
    end
  end

  def sorting
    if sort_column == "category_id" && params[:locale] == :en
      @jobs = Job.cat_by_name.paginate(:per_page => 20, :page => params[:page])
    elsif sort_column == "category_id" && params[:locale] == :tr
      @jobs = Job.cat_by_isim.paginate(:per_page => 20, :page => params[:page])
    else
      @jobs = Job.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    end

  end
  # Set the locale from parameters
  def set_locale
    I18n.locale = params[:locale] unless params[:locale].blank?
  end
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
    store_location
    redirect_to login_path, :notice => t('application_controller.access_denied.log_in_to_continue') and return false
  end

  def log_in (email, password)
   user = User.authenticate(email, password)
   #cookies.permanent[:auth_token] = user.auth_token    bu yontemle sign in olmuyor
   session[:user_id] = user.auth_token
  end

  def is_admin?
    if !current_user.nil?
      current_user.is_admin
    else
      false
    end
  end
  helper_method :is_admin?

end
