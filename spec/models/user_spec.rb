require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
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

  it "should have a unique email address" do
    duplicate_user = @user.dup
    @user.save
    expect(duplicate_user).to_not be_valid
  end

  it "should have an email address saved as lower case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(mixed_case_email.downcase).to eq(@user.reload.email)
  end

  it "should have a password" do 
    user_no_password = User.new(name: "Example User", email: "user@example.com")
    expect(user_no_password).to_not be_valid
  end

  it "should have a password present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).to_not be_valid
  end

  it "should have a minimum length password" do
    @user.password = @user.password_confirmation = "A" * 5
    expect(@user).to_not be_valid
  end


end
