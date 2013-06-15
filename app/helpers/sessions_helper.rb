module SessionsHelper

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  private
  def store_location
    session[:return_to] = search_by_cat_id_path(:locale => 'tr',:category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction],:keyword => params[:keyword], :page => params[:page]) #request.fullpath
    puts "In sessions_helper +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   #{session[:return_to]}"
  end
  def clear_return_to
    session[:return_to] = nil
  end
end

