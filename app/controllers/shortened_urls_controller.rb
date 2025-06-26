# app/controllers/shortened_urls_controller.rb

class ShortenedUrlsController < ApplicationController
  def index
    @shortened_urls = current_user.shortened_urls.order(created_at: :desc)
  end

  def create
    @shortened_url = current_user.shortened_urls.build(shortened_url_params)
    if @shortened_url.save
      redirect_to shortened_urls_path, notice: 'Shortened URL created successfully.'
    else
      @shortened_urls = current_user.shortened_urls.order(created_at: :desc)
      render :index, alert: 'Failed to create shortened URL.'
    end
  end

  private

  def shortened_url_params
    params.require(:shortened_url).permit(:original_url)
  end
end
