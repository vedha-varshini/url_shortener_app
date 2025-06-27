class User < ApplicationRecord
  has_secure_password

  has_many :shortened_urls, dependent: :destroy

  enum :role, { user: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password, presence: true,
            length: { minimum: 8 },
            format: {
              with: /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9])/,
              message: "must include one lowercase letter, one uppercase letter, one digit, and one special character"
            },
            if: -> { new_record? || !password.nil? }
end
