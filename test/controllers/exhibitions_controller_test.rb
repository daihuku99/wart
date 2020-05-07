require 'test_helper'

class ExhibitionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exhibitions_index_url
    assert_response :success
  end

  test "should get new" do
    get exhibitions_new_url
    assert_response :success
  end

  test "should get show" do
    get exhibitions_show_url
    assert_response :success
  end

  test "should get edit" do
    get exhibitions_edit_url
    assert_response :success
  end

  test "should get thanks" do
    get exhibitions_thanks_url
    assert_response :success
  end

end
