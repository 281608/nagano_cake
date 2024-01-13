require "test_helper"

class PublicsControllerTest < ActionDispatch::IntegrationTest
  test "should get homes" do
    get publics_homes_url
    assert_response :success
  end

  test "should get top" do
    get publics_top_url
    assert_response :success
  end
end
