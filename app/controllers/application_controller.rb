class ApplicationController < ActionController::Base
  
  protect_from_forgery with: :exception

  skip_forgery_protection if: -> { request.format.json? || request.content_type == "application/json" }

  helper_method :current_user, :user_signed_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user!
    redirect_to login_path, alert: 'You must be logged in to access this page.' unless user_signed_in?
  end

  def admin_only
    redirect_to shortened_urls_path, alert: 'Access denied!' unless current_user&.admin?
  end
end
