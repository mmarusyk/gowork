require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:misha)
    @category = Category.new(
      title: 'Design',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
    )
  end

  test 'should be valid' do
    assert @category.valid?
  end

  test 'title should be present' do
    @category.title = ' '
    assert_not @category.valid?
  end

end
