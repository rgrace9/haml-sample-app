require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: "Example User", email: "user@example.com")
  end
  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end
  it "has name present" do
    @user.name = "     "
    expect(@user).to_not be_valid
  end
  it "has email present" do
    @user.email = "     "
    expect(@user).to_not be_valid
  end

  it "has name that is not too long" do
    @user.name = "r" * 60
    expect(@user).to_not be_valid
  end

  it "has email that is not too long" do
    @user.email = "r" * 250 + "@example.net"
    expect(@user).to_not be_valid
  end

  it "should accept valid email addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
    @user.email = valid_address
    expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "should reject invalid email addresses" do
    
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
    end

  end

  it "show have a unique email address" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).to_not be_valid
  end
end
