require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'account_activation' do
    user = users(:misha)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    assert_equal 'Account activation', mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['goworkgo@ukr.net'], mail.from
    assert_match user.first_name, mail.text_part.body.to_s.encode("UTF-8")
    assert_match user.activation_token, mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(user.email), mail.text_part.body.to_s.encode("UTF-8")
  end

  test 'password_reset' do
    user = users(:misha)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["goworkgo@ukr.net"], mail.from
    assert_match user.reset_token, mail.text_part.body.to_s.encode("UTF-8")
    assert_match CGI.escape(user.email), mail.text_part.body.to_s.encode("UTF-8")
  end
end
