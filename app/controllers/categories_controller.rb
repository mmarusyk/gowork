class CategoriesController < ApplicationController
  before_action :admin_user, only: %i[index show create destroy new]

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Категорія створена!'
      redirect_to categories_url
    else
      render 'static_pages/home'
    end
  end

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def show
  end

  def new
    @category = Category.new
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Категорію видалено"
    redirect_to categories_url
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.try(:admin?)
  end

  def category_params
    params.require(:category).permit(:title, :description)
  end
end
