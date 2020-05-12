require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path
      assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name: '', last_name: '', email: 'user@invalid', city: '',  password: 'example', password_confirmation: 'example' } }
    end
    assert_template 'users/new'
  end
end
