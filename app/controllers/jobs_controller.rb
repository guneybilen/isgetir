class JobsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show, :notify_friend, :search]

  #respond_to :html, :js
  # autocomplete :name


  def search
    @jobse = Job.search(params[:keyword])
    puts @jobse.map{|p| [p.title, p.body, p.location]}.flatten.to_a
    #@jobs = ['ankara','izmir']
    #@jobs = @jobs.map{|p| p.title}.sort
    #@jobs2  = @jobs.map{|p| p.location}.sort
    #@jobs3 = @jobs.map{|p| p.body}.sort
    #@jobs = @jobs1 + @jobs2 + @jobs3
    #@jobs = @jobs.compact.collect {|i| i.to_s}.sort.uniq

    #     # burda sanirim index action'i invoke et DEGIL de
      # index action'in view template'i olan views/index.html.erb yi render et demek oluyor

    respond_to do |format|
      #format.html {render :action => 'index'}
      format.js
      format.json { render json: @jobs}
    end
  end

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
    @job = Job.find(params[:id])
    if Category.where("id= ?", @job.category_id).first.nil?
      @category = t('general.category_is_not_specified')
    else
      @category = Category.where("id= ?", @job.category_id).first.name
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.json
  def new
    @job = Job.new
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
    @job = current_user.jobs.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: t('jobs_controller.create.success') }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html do
          2.times do
            @job.references.build
          end

=begin
             @job.references.each do |d|
               unless d.name.blank? then @job.references.build end
             end
=end

          #2.times {}
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
        format.html { redirect_to @job, notice: t('jobs_controller.update.success') }
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
    @job = current_user.jobs.find(params[:id])

    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :ok }
    end
  end

  def notify_friend
    @job = Job.find(params[:id])
    Notifier.email_friend(@job, params[:name], params[:email]).deliver
    redirect_to @job, :notice => t('jobs_controller.notify_friend.success')
  end
end
