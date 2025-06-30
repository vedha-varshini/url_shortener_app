FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'Password1!' }
    password_confirmation { 'Password1!' }
    role { :user }
  end
end
