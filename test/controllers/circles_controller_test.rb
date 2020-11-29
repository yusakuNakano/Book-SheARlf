require 'test_helper'

class CirclesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get circles_index_url
    assert_response :success
  end

end
