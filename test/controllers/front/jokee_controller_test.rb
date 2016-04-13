require 'test_helper'

class Front::JokeeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
