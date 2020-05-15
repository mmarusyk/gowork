require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
  @user = users(:misha)
  end

  test 'profile display' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title("#{@user.first_name} #{@user.last_name}")
    assert_select 'h1', text: "#{@user.first_name} #{@user.last_name}"
    assert_select 'img.gravatar'
  end
end
