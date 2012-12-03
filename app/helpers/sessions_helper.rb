module SessionsHelper

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  private
  def store_location
    session[:return_to] = request.fullpath
    # puts "In sessions_helper %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #{session[:return_to]}"
  end
  def clear_return_to
    session[:return_to] = nil
  end
end

