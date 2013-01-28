class CommentsController < ApplicationController
  before_filter :load_job, :except => :destroy
  before_filter :authenticate, :only => :destroy


  def create
    @time_too_fast = ''
    time_later
    hidden_field

    @comment = @job.comments.new(params[:comment])

    #puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% #{@time_too_fast}"

    if(!@time_too_fast.blank?)
      flash.now[:notice] = t('general.too_fast')
       respond_to do |format|
        format.js { render 'fail_create.js.erb' and return false}
      end
    end

    if (!@hidden.blank?)
      flash.now[:notice] = t('general.hidden_text_field_change')
      respond_to do |format|
        format.js { render 'fail_create.js.erb' and return false}
      end
    end

    if @comment.save
      flash.now[:notice] = t('comments_controller.notice.thanks_for_comment')
      respond_to do |format|
        format.html { redirect_to @job }
        format.js
      end
    else
      flash.now[:alert] = t('comments_controller.alert.unable_to_add_comment')
      respond_to do |format|
        format.html { redirect_to @job }
        format.js { render 'fail_create.js.erb' }
      end
    end
  end

  def destroy
    if !(current_user.is_admin?)
      begin
        @job = current_user.jobs.find(params[:job_id])
      rescue ActiveRecord::RecordNotFound
        flash.now[:alert] = t('comments_controller.alert.deleting_other_users_comments')
        redirect_to Job.find(params[:job_id])
        #render :text => "You cannot delete other people's comment"
      end
    else
      @job = Job.find_by_id(params[:job_id])
    end

    if !@job.nil?
      @comment = @job.comments.find(params[:id])
      @comment.destroy
      flash.now[:notice] = t('comments_controller.notice.comment_deleted')
      respond_to do |format|
        format.html { redirect_to @job }
        format.js
      end
    end
  end

  private
  def load_job
    @job = Job.find(params[:job_id])
  end
end