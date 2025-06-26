require "test_helper"

class RedirectControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get redirect_show_url
    assert_response :success
  end
end
