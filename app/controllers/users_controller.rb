class UsersController < ApplicationController
  before_action :load_user, only: :show
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)


 def index
    @users = User.paginate(page: params[:page])
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t(:pls_chk_email)
      redirect_to @user
    else
      render :new
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user&.destroy
      flash[:success] = t(:User_deleted)
    else
        flash[:danger] = t(:Delete_fail)
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t(:error)
    redirect_to root_path
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t(:Please_log_in)
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    return if current_user?(@user)
    flash[:danger]= t(:you_are_not_authorized)
    redirect_to(root_url)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
