module ApplicationHelper


  def title
    base_title = 'isgetir.com'

    if !@title.nil?
      "#{base_title} | #{@title}"
    else
      base_title
    end
  end

  # Creates a submit button with the given name with a cancel link
  # Accepts two arguments: Form object and the cancel link name
  def submit_or_cancel(form, name='Cancel')
    form.submit + " or " +
        link_to(name, root_path, :class => "for_black_font_link")
        #link_to(name, 'javascript:history.go(-1);', :class => 'cancel')
  end

  def language_selector
    result1 = params[:job].nil?
    #result2 = params[:keyword].nil?
    #result3 = result1 && result2
    #result4 = !result1 || !result2
    #puts("$$$$$$$$$$$$$$$$$$$$$#{params[:locale]}                $$$$$$$$$$$$$#{params[:category_id].nil?}          $$$$$$$$#{params[:keyword].nil?}")
    if I18n.locale == :en  && !result1 #(!params[:category_id].blank? || !params{:keyword}.blank?)
      link_to(image_tag("Turkey.png", :id => "turkish_flag"), url_for(:locale => 'tr',:category_id => params[:job][:category_id], :sort => params[:sort], :direction => params[:direction],:keyword => params[:keyword], :page => params[:page]))

    elsif I18n.locale == :tr && !result1 #(!params[:category_id].blank? || !params{:keyword}.blank?)
      link_to(image_tag("United_Kingdom.png", :id => "english_flag"), url_for(:locale => 'en', :category_id => params[:job][:category_id], :sort => params[:sort], :direction => params[:direction], :keyword => params[:keyword], :page => params[:page]))

    elsif I18n.locale == :en  # && !result #(!params[:category_id].blank? || !params{:keyword}.blank?)
      link_to(image_tag("Turkey.png", :id => "turkish_flag"), url_for(:locale => 'tr',:category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction],:keyword => params[:keyword], :page => params[:page]))

    elsif I18n.locale == :tr  # && !result #(!params[:category_id].blank? || !params{:keyword}.blank?)
      link_to(image_tag("United_Kingdom.png", :id => "english_flag"), url_for(:locale => 'en', :category_id => params[:category_id], :sort => params[:sort], :direction => params[:direction], :keyword => params[:keyword], :page => params[:page]))

    end
  end


def sortable(column, title = nil, klass)
  title ||= column.titleize
  css_class = column == sort_column ? "current #{sort_direction}" : nil
  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
  link_to title, params.merge(:sort => column, :direction => direction, :page=>nil),
          {:class => css_class}
end

# enable i18n in will_paginate
include WillPaginate::ViewHelpers

  def will_paginate_with_i18n(collection = nil, options = {})
    will_paginate collection, options.merge(:previous_label => t('will_paginate.previous'),
                                            :next_label => t('will_paginate.next'))
  end
end
