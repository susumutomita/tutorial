require "test_helper"

# sessions test
class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end
end
