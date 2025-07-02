class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy, :urls]

  def index
    @users = Rails.cache.fetch('all_users', expires_in: 10.minutes) do
      User.where(role: :user).order(created_at: :desc).to_a
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      Rails.cache.delete('all_users')  # Invalidate cache
      redirect_to admin_users_path, notice: "User created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      Rails.cache.delete('all_users')  # Invalidate cache
      redirect_to admin_users_path, notice: "User updated."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    Rails.cache.delete('all_users')  # Invalidate cache
    redirect_to admin_users_path, notice: "User deleted."
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
    redirect_to shortened_urls_path, alert: "Access denied!" unless current_user&.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
