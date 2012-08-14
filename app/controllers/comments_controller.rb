class CommentsController < ApplicationController
  before_filter :load_job, :except => :destroy
  before_filter :authenticate, :only => :destroy


  def create
    @comment = @job.comments.new(params[:comment])
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @job, :notice => 'Thanks for your comment'}
        format.js
      end
    else
      respond_to do |format|
        format.html {redirect_to @job, :alert => 'Unable to add comment'}
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  def destroy
    begin
      @job = current_user.jobs.find(params[:job_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to Job.find(params[:job_id]), :alert => "You cannot delete other people's comments!"
      #render :text => "You cannot delete other people's comment"
    end

    if !@job.nil?
      @comment = @job.comments.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html {redirect_to @job, :notice => 'Comment deleted'}
        format.js
      end
    end
  end

  private
  def load_job
    @job = Job.find(params[:job_id])
  end
end