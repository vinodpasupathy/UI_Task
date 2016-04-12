require 'test_helper'

class FacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get vertical" do
    get :vertical
    assert_response :success
  end

  test "should get compare" do
    get :compare
    assert_response :success
  end

  test "should get spellcheck" do
    get :spellcheck
    assert_response :success
  end

  test "should get uom" do
    get :uom
    assert_response :success
  end

  test "should get col_comp" do
    get :col_comp
    assert_response :success
  end

end
