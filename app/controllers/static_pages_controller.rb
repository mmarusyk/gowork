class StaticPagesController < ApplicationController
  def index
  end
  
  def home
    if logged_in?
      @order = current_user.orders.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def howitswork
  end
end
