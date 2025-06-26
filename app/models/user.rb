class User < ApplicationRecord
  
  validates :role, inclusion: { in: %w[admin user], message: "%{value} is not a valid role" }

  has_many :shortened_urls
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end
end
