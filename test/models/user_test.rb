require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      first_name: 'Misha',
      last_name: 'Mrsk',
      email: 'user@example.com',
      city: 'Lviv',
      description: 'I am developer. I know HTML, CSS, Bootstrap, Ruby, Java',
      password: 'example',
      password_confirmation: 'example'
    )
    @category = categories(:cars)
  end
  test 'should be valid' do
    assert @user.valid?
  end
  test 'first_name should be present' do
    @user.first_name = ' '
    assert_not @user.valid?
  end
  test 'last_name should be present' do
    @user.last_name = ' '
    assert_not @user.valid?
  end
  test 'city should be present' do
    @user.city = ' '
    assert_not @user.valid?
  end
  test 'email should be present' do
    @user.email = ' '
    assert_not @user.valid?
  end
  test 'first_name should not be too long' do
    @user.first_name = 'a' * 51
    assert_not @user.valid?
  end
  test 'last_name should not be too long' do
    @user.last_name = 'a' * 51
    assert_not @user.valid?
  end
  test 'city should not be too long' do
    @user.city = 'a' * 51
    assert_not @user.valid?
  end
  test 'email should not be too long' do
    @user.email = 'a' * 51
    assert_not @user.valid?
  end
  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  test 'email addresses should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 6
    assert_not @user.valid?
  end
  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test 'assocoated orders should be destroyed' do
    @user.save
    @user.orders.create!(
      title: 'Wash car',
      description: 'I want to wash my car. I need help!',
      skills: 'Washing',
      city: 'Kyiv',
      price: 2000.50,
      duedate: '11.07.2020',
      category_id: @category.id
    )
    assert_difference 'Order.count', -1 do
      @user.destroy
    end
  end
end
