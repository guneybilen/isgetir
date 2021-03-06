# encoding: utf-8


require 'will_paginate/array'

# https://github.com/mislav/will_paginate/issues/163
# The Array#paginate method still exists, too, but is not loaded by default.
# If you need to paginate static arrays, first require it in your code:
# require 'will_paginate/array'

# for the following error that happened to me:
# NoMethodError (undefined method `paginate' for []:Array):
# app/controllers/jobs_controller.rb:57:in `search_by_category'

class JobsController < ApplicationController
  before_filter :authenticate,
                :except => [:index, :show, :notify_friend, :search,
                            :search_autocomplete, :search_by_cat_id]

  #respond_to :html, :js

  helper_method :sort_column, :sort_direction


  def search_by_cat_id
      if params[:page].to_s == ""
        #puts "**********             #{params}       ***************"
        params[:page]=1
      end

    if !params[:job].nil?
      if params[:job][:category_id].nil?
        #puts "************************************************0*************************************************"
        sorting
      end


      if params[:job][:category_id].to_s==""
        #puts "************************************************1*************************************************"
        sorting
      end

      if params[:job][:category_id].to_i > 0
        @jobs = Job.search_by_category(params[:job][:category_id]).order(sort_column + " " + sort_direction)
        #puts "**********             #{params}       *********************************** #{@jobs.inspect}"
        #puts "*************************Jobs is not nil********************************              ***************"
        @jobs_paged = @jobs.paginate(:per_page => 20, :page => params[:page])
      end
    end

    if params[:job].nil? && params[:category_id].to_s==""
      #puts "************************************************2*************************************************"
      sorting
    end

    if params[:category_id].to_i > 0
        @jobs = Job.search_by_category(params[:category_id]).order(sort_column + " " + sort_direction)
        #puts "**********             #{params}       *********************************** #{@jobs.inspect}"
        #puts "*************************Jobs is nil********************************              ***************"
        @jobs_paged = @jobs.paginate(:per_page => 20, :page => params[:page])
    end

        @jobs = @jobs.paginate(:per_page => 20, :page => params[:page])
      #puts "**********             #{params}       *********************************** #{@jobs_paged.nil?}"

      if !@jobs_paged.nil? && @jobs_paged.empty?
        #puts "**********             #{params}       ***************Jobs Empty ******************************** #{@jobs.inspect}"
        @jobs = @jobs.paginate(:per_page => 20, :page => 1)

      end

    #if params[:locale]=="tr"
    #  I18n.locale = :tr
    #end
    #if params[:locale]=="en"
    #  I18n.locale = :en
    #end

    #end

    render 'index'

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.js  # burda ajaxing.js.erb invoke edilsin istiyorum
    #  format.json { render json: @jobs }
    #end
  end


  def search

    if params[:page].to_s == ""
      #puts "**********             #{params}       ***************"
      params[:page]=1
    end

    if (params[:category_id]=="0")
      puts "(((((((((((((((((((((((((((((#{params[:keyword].blank?})))))))))))))))))))))))))))))))))))))))"
      #@jobs = Job.limit(0).paginate(:per_page => 1, :page => params[:page])
      @jobs = Job.order(sort_column + " " + sort_direction)
          .paginate(:per_page => 20, :page => params[:page])
      return
    end

    if (params[:keyword].blank?)
      puts "(((((((((((((((((((((((((((((#{params[:keyword].blank?})))))))))))))))))))))))))))))))))))))))"
      #@jobs = Job.limit(0).paginate(:per_page => 1, :page => params[:page])
      @jobs = Job.order(sort_column + " " + sort_direction)
          .paginate(:per_page => 20, :page => params[:page])
      redirect_to :action => :index
      return
    else

      # @jobs = Job.find(params[:keyword]).order(sort_column + " " + sort_direction)  hata veriyor array has not method order
      @jobs = Job.find_by_sql(" SELECT *  FROM JOBS WHERE id IN(#{params[:keyword]}) ORDER BY #{sort_column} #{sort_direction}")
      @jobs = @jobs.paginate(:per_page => 20, :page => params[:page])
      puts "(((((((((((((((((((((((((((((#{@jobs})))))))))))))))))))))))))))))))))))))))"
      #@jobs = Job.search(params[:keyword].gsub(' ', '').strip).order(sort_column + " " + sort_direction)
      #  .paginate(:per_page => 20, :page => params[:page])
      render "index" and return
    end

    puts "(((((((((((((((((((((((((((((#{params[:locale]})))))))))))))))))))))))))))))))))))))))"

=begin
    if params[:locale]=="tr"
      I18n.locale = :tr
    end
    if params[:locale]=="en"
      I18n.locale = :en
    end
=end

      respond_to do |format|
        #format.html {redirect_to @jobs_path}     # burda sanirim index action'i invoke et DEGIL de
        # index action'in view template'i olan views/index.html.erb yi render et demek oluyor
        format.js
        format.json { render json: @jobs}

    end
  end

  def search_autocomplete
    #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{params[:keyword].gsub('+', '').strip}$$$$$$$$$$$$$$$$$$"
    #stripped = params[:keyword].gsub('+', '').strip
    #puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#{stripped}$$$$$$$$$$$$$$$$$$"
    keyword = params[:q]
    h= Array.new
    if (keyword.length > 1)
      @jobs = Job.search(keyword)
      @jobs.each do |job|
      @jobs = h << ({:id => job.id, :name => job.body.truncate(40, :separator => ' '), :location => job.location})
      end
       puts @jobs
      #@jobs = @jobs.map{|p| [p.title, p.body, p.location]}.flatten.reject(&:nil?).reject(&:blank?)
      #                    .uniq.map(&:capitalize).sort.to_json


            #.sort_by{|p| p.length}

      #@jobs = @jobs..map{|p| p.strip}
      #@jobs = ["Ankara", "Erzurum"]

      #@jobs = [{:id => "856", :name => "House"}, {:id =>"1035", :name => "Desperate Housewives"}]


      respond_to do |format|
        #format.html {render :action => 'index'}
        format.js
        format.json { render json: @jobs}  #autocomplete icin format.json { render json: @jobs} gerekiyor
      end
    end
  end

  # GET /jobs
  # GET /jobs.json
  def index
=begin
    if sort_column == "category_id" && params[:locale] == :en
      @jobs = Job.cat_by_name.paginate(:per_page => 1, :page => params[:page])
    elsif sort_column == "category_id" && params[:locale] == :tr
      @jobs = Job.cat_by_isim.paginate(:per_page => 1, :page => params[:page])
    else
      @jobs = Job.order(sort_column + " " + sort_direction).paginate(:per_page => 1, :page => params[:page])
    end
=end
    @title = t('general.main_list')

=begin
    if params[:locale]=="tr"
      loc = "tr"
    end
    if params[:locale]=="en"
      loc = "en"
    end
=end

    sorting # defined in the application controller

    respond_to do |format|
      format.html # index.html.erb
      #format.js
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    session[:time_now] = Time.now

    @job = Job.find(params[:id])
    if (Category.where("id = ?", @job.category_id).first.nil? ||
        Category.where("id = ?", @job.category_id).map{|p| p.isim} == ["Diğer"] ||
        Category.where("id = ?", @job.category_id).map{|p| p.isim} == ["Other"])
      @category = t('general.category_is_not_specified')
    elsif I18n.locale == :en
      @category = Category.where("id= ?", @job.category_id).first.name
    elsif I18n.locale == :tr
      @category = Category.where("id= ?", @job.category_id).first.isim
    end

    if request.xhr?
      render 'show_ajax', :layout => false
      #respond_to do |format|
      #  format.js
      #end

    else

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @job }
      end
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new

    session[:time_now] = Time.now

    2.times do
      @job.references.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    @job = current_user.jobs.find(params[:id])
    @references = @job.references.all
    if @references.count == 0
      2.times do
        @job.references.build
      end
    end
    if @references.count == 1
      1.times do
        @job.references.build
      end
    end
  end

  # POST /jobs
  # POST /jobs.json
  def create
    if current_user.nil?
       redirect_to login_path and return false
    end

    @job = current_user.jobs.new(params[:job])


    @time_too_fast = ''

    #time_later # defined in application controller
    hidden_field  # defined in application controller

    respond_to do |format|
      if !@job.valid?
           @hidden = nil
           @time_too_fast = nil
           format.html do
        2.times do
          @job.references.build
          end

          render action: "new"
        end

        format.json { render json: @job.errors, status: :unprocessable_entity }
      end

      #puts @job.valid?
      #p @hidden

      if ((@hidden.blank? || @hidden.nil?) && @time_too_fast.blank?) && @job.save
        #p @job
        flash[:notice] = t('jobs_controller.create.success')
        format.html { redirect_to @job}
        format.json { render json: @job, status: :created, location: @job }
      else

        format.html do
          2.times do
            @job.references.build
            end

          render action: "new"
        end

        format.json { render json: @job.errors, status: :unprocessable_entity }

      end
    end
  end


  # PUT /jobs/1
  # PUT /jobs/1.json
  def update
    @job = current_user.jobs.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = t('jobs_controller.update.success')
        format.html { redirect_to @job}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
     if current_user.nil?
       redirect_to login_path and return false
     end

     #p current_user
     #p current_user.jobs

    if current_user.jobs.empty?
      redirect_to root_path and return false
    end

    if current_user.is_admin?
      @job = Job.find(params[:id])
    else
      @job = current_user.jobs.find(params[:id])
    end

    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :ok }
    end
  end

  def notify_friend
    @job = Job.find(params[:id])

    @time_too_fast = ''
    time_later    # defined in application controller
    hidden_field  # defined in application controller

    if (params[:name].blank? || params[:email].blank?)
      flash[:notice] = t('general.notify_friend_missing_information')
      render 'show' and return
    end

    if (@hidden.blank? && @time_too_fast.blank?)
      Notifier.email_friend(@job, params[:name], params[:email]).deliver
      flash[:notice] = t('jobs_controller.notify_friend.success')
      redirect_to @job
    else
      #params[:notice] = "Missing $$$$$$$$$$$$$$$$$$$$$ #{@hidden} #{@time_too_fast} $$$$$$$$$$$$ Information"
      render 'show'
    end

  end

  def user_jobs
    @jobs = current_user.jobs.paginate(:per_page => 20, :page => params[:page])
    render 'index'
  end

  private

  def sort_column
    Job.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
