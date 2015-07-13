require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get convos" do
    get :convos
    assert_response :success
  end

end
