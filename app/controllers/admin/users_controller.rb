class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy, :urls]

  def index
    @users = User.where(role: 'user')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "User deleted successfully."
    else
      redirect_to admin_users_path, alert: "Failed to delete user."
    end
  end

  def urls
    @shortened_urls = @user.shortened_urls
  end

  def confirm_delete
    @user = User.find_by(id: params[:id])
    unless @user
      flash[:alert] = "User not found."
      redirect_to admin_users_path
    end
  end

  private

  def ensure_admin
    redirect_to authenticated_root_path, alert: "Access denied!" unless current_user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
