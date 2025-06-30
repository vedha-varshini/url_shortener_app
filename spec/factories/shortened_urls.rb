FactoryBot.define do
  factory :shortened_url do
    original_url { "https://example.com" }
    short_code { SecureRandom.hex(3) }
    user
  end
end
