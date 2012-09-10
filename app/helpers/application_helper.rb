module ApplicationHelper
  # Creates a submit button with the given name with a cancel link
  # Accepts two arguments: Form object and the cancel link name
  def submit_or_cancel(form, name='Cancel')
    form.submit + " or " +
        link_to(name, root_path, :class => "for_black_font_link")
        #link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end

  def language_selector
    if I18n.locale == :en
      link_to image_tag("Turkey.png", :id => "turkish_flag"), url_for(:locale => 'tr')
    else
      link_to image_tag("United_Kingdom.png", :id => "english_flag"), url_for(:locale => 'en')
    end
  end



def sortable(column, title = nil)
  title ||= column.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
end


end
