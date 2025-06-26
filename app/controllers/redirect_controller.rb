class RedirectController < ApplicationController
  def show
    url = ShortenedUrl.find_by(short_code: params[:short_code])
    if url.nil?
      render plain: 'URL not found', status: :not_found
    elsif url.expired?
      render plain: 'URL expired', status: :gone
    else
      redirect_to url.original_url, allow_other_host: true
    end
  end
end
