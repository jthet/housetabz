require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:john_doe) # Get the user labeled "one" from users.yml
  end

  def test_username
    assert_equal 'john_doe', @user.username
  end
end
