class ShortenedUrl < ApplicationRecord
  belongs_to :user

  validates :original_url, presence: true
  validates :short_code, uniqueness: true

  before_create :generate_short_code, :set_expiry

  scope :active, -> { where('expired_at > ?', Time.current) }

  def generate_short_code
    self.short_code = SecureRandom.hex(3)
  end

  def set_expiry
    self.expired_at = 48.hours.from_now
  end

  def expired?
    expired_at < Time.current
  end
end
