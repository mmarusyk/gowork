require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @order = orders(:one)
    @category = categories(:cars)
  end
  
  test 'should redirect create when not logged in' do
    assert_no_difference 'Order.count' do
      post orders_path, params: {
        title: 'Wash car',
        description: 'I want to wash my car. I need help!',
        skills: 'Washing',
        city: 'Kyiv',
        price: 2000.50,
        duedate: '11.07.2020',
        category_id: @category.id
      }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Order.count' do
      delete order_path(@order)
    end
    assert_redirected_to login_url
  end
end
