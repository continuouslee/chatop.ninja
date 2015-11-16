require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get websocket" do
    get :websocket
    assert_response :success
  end

end
