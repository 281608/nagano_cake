require "test_helper"

class Public::ShippingControllerTest < ActionDispatch::IntegrationTest
  test "should get addresses" do
    get public_shipping_addresses_url
    assert_response :success
  end
end
