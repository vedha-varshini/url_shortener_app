class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user.admin? ? admin_users_path : shortened_urls_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Logged out successfully.'
  end
end
