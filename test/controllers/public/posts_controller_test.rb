require "test_helper"

class Public::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_posts_create_url
    assert_response :success
  end

  test "should get show" do
    get public_posts_show_url
    assert_response :success
  end

  test "should get destroy" do
    get public_posts_destroy_url
    assert_response :success
  end
end
