require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
    assert_select 'title', 'Головна | GoWork App'
  end

  test "should get home" do
    get home_path
    assert_response :success
    assert_select 'title', 'Головна | GoWork App'
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select 'title', 'Допомога | GoWork App'
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select 'title', 'Про нас | GoWork App'
  end

end
