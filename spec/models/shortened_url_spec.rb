require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should define_enum_for(:role).with_values(user: 0, admin: 1) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should allow_value('user@example.com').for(:email) }
  it { should_not allow_value('invalid-email').for(:email) }

  it { should validate_length_of(:password).is_at_least(8) }

  it "validates password complexity - invalid" do
    user = build(:user, password: 'simplepwd')
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("must include at least one lowercase letter, one uppercase letter, one digit, and one special character")
  end

  it "validates password complexity - valid" do
    user = build(:user, password: 'Valid123!')
    expect(user).to be_valid
  end

  it "is invalid without email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is valid with all fields" do
    user = build(:user, email: "valid@example.com", password: "Password1!")
    expect(user).to be_valid
  end
end
