require 'test_helper'

class StateTestsControllerTest < ActionDispatch::IntegrationTest
  test "should get test" do
    get state_tests_test_url
    assert_response :success
  end

end
