class ApplicationController < ActionController::Base
  include SessionsHelper
  def hello
    render html: 'Hello world'
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Увійдіть будь ласка.'
      redirect_to login_url
    end
  end
end
