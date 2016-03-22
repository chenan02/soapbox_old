require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(phone_number: "2483809188", password: "password", password_confirmation: "password")
  end

  test "is valid" do
    assert @user.valid?
  end

  test "phone number present" do
  	@user.phone_number = ""
  	assert_not @user.valid?
  end

  test "phone number should not be too long" do
  	@user.phone_number = "12345678900"
  	assert_not @user.valid?
  end

  test "phone numbers should be unique" do
  	duplicate_user = @user.dup
  	duplicate_user.phone_number = @user.phone_number
  	@user.save
  	assert_not duplicate_user.valid?
  end

  test "password should be present" do
  	@user.password = @user.password_confirmation = " " * 6
  	assert_not @user.valid?
  end

  test "password should have a minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
  	assert_not @user.authenticated?(:remember, '')
  end
end
