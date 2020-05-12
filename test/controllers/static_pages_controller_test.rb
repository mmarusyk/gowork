require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
    assert_select 'title', 'Головна | GoWork App'
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select 'title', 'Головна | GoWork App'
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select 'title', 'Допомога | GoWork App'
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select 'title', 'Про нас | GoWork App'
  end

end
