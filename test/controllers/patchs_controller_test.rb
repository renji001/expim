require 'test_helper'

class PatchsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get patchs_index_url
    assert_response :success
  end

end
