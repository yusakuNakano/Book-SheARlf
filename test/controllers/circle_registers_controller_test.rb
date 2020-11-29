require 'test_helper'

class CircleRegistersControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get circle_registers_register_url
    assert_response :success
  end

end
