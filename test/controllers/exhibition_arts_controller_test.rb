require 'test_helper'

class ExhibitionArtsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get exhibition_arts_show_url
    assert_response :success
  end

end
