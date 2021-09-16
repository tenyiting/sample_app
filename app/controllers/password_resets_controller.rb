class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: [:edit, :update]

  def new; end

  def edit; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t(:ins_reset_password)
      redirect_to root_url
    else
      flash.now[:danger] = t(:not_found_e_address)
      render :new
    end
  end

  def update
    if user_params[:password].empty?
      @user.errors.add(:password, t(:empty_password))
      render "edit"
    elsif @user.update_attributes user_params
      log_in @user
      flash[:success] = t(:reset_password)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def get_user
    @user = User.find_by email: params[:email]
  end

  def valid_user
    return if (@user && @user.activated && @user.authenticated?(:reset, params[:id]))
    redirect_to root_url
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = t(:exp_reset_password)
      redirect_to new_password_reset_url
    end
  end

  def check_expiration
    return unless @user.password_reset_expired?
    flash[:danger] = t(:exp_reset_password)
    redirect_to new_password_reset_url
  end
end
