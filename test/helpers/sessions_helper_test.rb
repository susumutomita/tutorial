require 'test_helper'

# SessionsHelperTestはSessionsHelperのテストです。
class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    @user2 = users(:archer)
  end

  test "debug test logged_in" do
    remember(@user2)
    assert_equal @user2, current_user
    assert logged_in?
  end

  test "current_user returns right user when session is nil" do
    remember(@user)
    assert_equal @user, current_user
    assert logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update(remember_digest: User.digest(User.new_token))
    assert_nil current_user
  end
end
