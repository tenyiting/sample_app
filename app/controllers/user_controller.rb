class UsersController < ApplicationController
  before_action :laod_user, only: :show

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)  # Not the final implementation!
    if @user.save
      flash[:success] = t(:welcome)
      redirect_to users_new_url(@user)
    else
      render :new
    end
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
end
