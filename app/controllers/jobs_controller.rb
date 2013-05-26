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
                            :search_autocomplete, :ajaxing]

  #respond_to :html, :js

  helper_method :sort_column, :sort_direction


  def ajaxing

    if params[:category_id].blank? && params[:job][:category_id].blank?
      puts "**********             #{params[:job]}       **************Category_id is Empty*********************"

      sorting
    else

      if !params[:job].nil?
        @jobs = Job.search_by_category(params[:job][:category_id]).order(sort_column + " " + sort_direction)
        puts "*************************Jobs is not nil*****************    #{params[:job]}    ******************************"

      else
        @jobs = Job.search_by_category(params[:category_id]).order(sort_column + " " + sort_direction)
        #puts "**********             #{params}       *********************************** #{@jobs.inspect}"
        puts "*************************Jobs is nil***********************************************"
        @jobs_paged = @jobs.paginate(:per_page => 20, :page => params[:page])
      end


        @jobs = @jobs.paginate(:per_page => 20, :page => params[:page])
      #puts "**********             #{params}       *********************************** #{@jobs_paged.nil?}"

      if !@jobs_paged.nil? && @jobs_paged.empty?
        #puts "**********             #{params}       ***************Jobs Empty ******************************** #{@jobs.inspect}"
        @jobs = @jobs.paginate(:per_page => 20, :page => 1)

      end

    end


    respond_to do |format|
      #format.html # index.html.erb
      format.js  # burda ajaxing.js.erb invoke edilsin istiyorum
      #format.json { render json: @jobs }
    end
  end


  def search
    if (params[:keyword].blank?)
      #@jobs = Job.limit(0).paginate(:per_page => 1, :page => params[:page])
      @jobs = Job.order(sort_column + " " + sort_direction)
          .paginate(:per_page => 20, :page => params[:page])
      return
    else
      @jobs = Job.search(params[:keyword]).order(sort_column + " " + sort_direction)
        .paginate(:per_page => 20, :page => params[:page])
    end

      respond_to do |format|
        #format.html {redirect_to @jobs_path}     # burda sanirim index action'i invoke et DEGIL de
        # index action'in view template'i olan views/index.html.erb yi render et demek oluyor
        format.js
        format.json { render json: @jobs}

    end
  end

  def search_autocomplete
    if (params[:keyword].length > 1)
      @jobs = Job.search(params[:keyword])
      @jobs = @jobs.map{|p| [p.title, p.body, p.location]}.flatten.reject(&:nil?).reject(&:blank?)
                          .uniq.map(&:capitalize).sort
            #.sort_by{|p| p.length}

      #@jobs = @jobs..map{|p| p.strip}
      #@jobs = ["Ankara", "Erzurum"]

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
    sorting # defined in the application controller

    respond_to do |format|
      format.html # index.html.erb
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

    @job = current_user.jobs.find(params[:id])


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

  private

  def sort_column
    Job.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
