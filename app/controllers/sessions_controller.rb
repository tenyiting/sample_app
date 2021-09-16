class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:sessions][:email].downcase
    if @user&.authenticate (params[:sessions][:password])
      if @user.activated?
        log_in @user
        params[:sessions][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        message = t(:not_activated)
        flash[:warning] = message
        redirect_to home_url
      end
    else
      flash.now[:danger] = t(:invalid_email_password)
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to home_path
  end
end
