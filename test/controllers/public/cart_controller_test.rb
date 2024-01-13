require "test_helper"

class Public::CartControllerTest < ActionDispatch::IntegrationTest
  test "should get items" do
    get public_cart_items_url
    assert_response :success
  end
end
