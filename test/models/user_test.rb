require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(phone_number: "2483809188")
  end

  test "is valid" do
    assert @user.valid?
  end
end
