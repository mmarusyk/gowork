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
    assert_match @user.orders.count.to_s, response.body
    assert_select 'div.pagination'
    @user.orders.paginate(page: 1).each do |order|
      assert_match order.title, response.body
    end
  end
end
