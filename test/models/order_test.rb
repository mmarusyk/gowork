require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @user = users(:misha)
    @category = categories(:cars)
    @order = Order.new(
      title: 'Wash car',
      description: 'I want to wash my car. I need help!',
      skills: 'Washing',
      city: 'Kyiv',
      price: 2000.50,
      duedate: '11.07.2020',
      user_id: @user.id,
      category_id: @category.id
    )
  end

  test 'should be valid' do
    assert @order.valid?
  end

  test 'user id should be present' do
    @order.user_id = nil
    assert_not @order.valid?
  end

  test 'category id should be present' do
    @order.category_id = nil
    assert_not @order.valid?
  end

  test 'title should be present' do
    @order.title = '   '
    assert_not @order.valid?
  end

  test 'title should be at most 50 characters' do
    @order.title = 'a' * 51
    assert_not @order.valid?
  end

  test 'description should be present' do
    @order.description = '   '
    assert_not @order.valid?
  end

  test 'description should be at most 500 characters' do
    @order.description = 'a' * 501
    assert_not @order.valid?
  end

  test 'city should be present' do
    @order.city = '   '
    assert_not @order.valid?
  end

  test 'price should be present' do
    @order.price = nil
    assert_not @order.valid?
  end
end
