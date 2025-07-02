class ShortenedUrl < ApplicationRecord
  belongs_to :user

  validates :original_url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }

  before_validation :add_url_scheme
  before_create :generate_short_code

  def expired?
    expired_at.present? && Time.current > expired_at
  end

  private

  def add_url_scheme
    return if original_url.blank?

    unless original_url[%r{\Ahttps?://}]
      self.original_url = "https://#{original_url}"
    end
  end

  def generate_short_code
    self.short_code = SecureRandom.urlsafe_base64(6)
  end
end
