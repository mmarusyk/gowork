class OrdersController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy
  def index
    @orders = Order.paginate(page: params[:page])
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = current_user.orders.build if logged_in?
  end

  def create
    @order = current_user.orders.build(order_params)
    if @order.save
      flash[:success] = "Замовлення створено!"
      redirect_to orders_url(current_user)
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @order.destroy
    flash[:success] = 'Замовлення видалено'
    redirect_to request.referrer || orders_url(current_user)
  end

  private

  def order_params
    params.require(:order).permit(
      :title,
      :description,
      :skills,
      :city,
      :duedate,
      :category_id,
      :price
    )
  end

  def correct_user
    @order = current_user.orders.find_by(id: params[:id])
    redirect_to orders_url(current_user) if @order.nil?
  end
end
