require "test_helper"

# Maier test
class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:michael)
  end

  test "account_activation" do
    mail = UserMailer.account_activation(@user)
    assert_equal "Account activation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "password_reset" do
    mail = UserMailer.password_reset
    assert_equal "Password reset", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
