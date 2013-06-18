module SessionsHelper

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  private
  def store_location
    puts "In sessions_helper ------------------------------------------------------------------   #{session[:return_to]}"

    session[:return_to] = path_to  # path_to defined in application_controller
=begin
if params[:category_id] != "" && params{:category_id} != "0"
      session[:return_to] = search_by_cat_id_path(:locale => 'tr',:category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction]) #request.fullpath
    elsif params[:page].to_i > 1
      session[:return_to] = root_path(:locale => 'tr',:category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction],:keyword => params[:keyword], :page => params[:page]) #request.fullpath
      puts "In sessions_helper +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++   #{session[:return_to]}"
    elsif params[:keyword] != ""
      session[:return_to] = search_path(:locale => 'tr',:category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction],:keyword => params[:keyword], :page => params[:page])
      puts "In sessions_helper ???????????????????????????????????????????????????????????????????   #{session[:return_to]}"
    end
=end
  end
  def clear_return_to
    session[:return_to] = nil
  end
end

