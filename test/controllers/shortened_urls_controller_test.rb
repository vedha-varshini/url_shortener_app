require "test_helper"

class ShortenedUrlsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shortened_urls_index_url
    assert_response :success
  end

  test "should get new" do
    get shortened_urls_new_url
    assert_response :success
  end

  test "should get create" do
    get shortened_urls_create_url
    assert_response :success
  end
end
