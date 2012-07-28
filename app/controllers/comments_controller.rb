class CommentsController < ApplicationController
  before_filter :load_job

  def create
    @comment = @job.comments.new(params[:comment])
    if @comment.save
      redirect_to @job, :notice => 'Thanks for your comment'
    else
      redirect_to @job, :alert => 'Unable to add comment'
    end
  end

  def destroy
    @comment = @job.comments.find(params[:id])
    @comment.destroy
    redirect_to @job, :notice => 'Comment deleted'
  end

  private
  def load_job
    @job = Job.find(params[:job_id])
  end
end