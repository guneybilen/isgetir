class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user

    if user.nil?
      flash[:notice] = t('password_resets_controller.create.failure')
    else
      flash[:notice] = t('password_resets_controller.create.success')
    end

    redirect_to root_url
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if params[:user][:password].blank?
      @user.errors.add('', t('general.password_cannot_be_blank'))
      render :action => 'edit'
    elsif @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => t('password_resets_controller.update.password_expired')
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => t('password_resets_controller.update.success')
    else
      render :edit
    end
  end
end
