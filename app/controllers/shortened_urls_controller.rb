class ShortenedUrlsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :authenticate_user!

  def new
    @shortened_url = ShortenedUrl.new
  end

  def index
    @shortened_urls = Rails.cache.fetch("user_#{current_user.id}_urls", expires_in: 5.minutes) do
      current_user.shortened_urls.order(created_at: :desc).to_a
    end
  end

  def create
    @shortened_url = current_user.shortened_urls.build(shortened_url_params)

    if @shortened_url.save
      Rails.cache.delete("user_#{current_user.id}_urls")
      redirect_to shortened_urls_path, notice: "URL shortened successfully."
    else
      flash.now[:alert] = @shortened_url.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def shortened_url_params
    params.require(:shortened_url).permit(:original_url)
  end
end
