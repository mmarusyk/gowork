class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
    # @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @orders = @user.orders.paginate(page: params[:page])
    redirect_to root_url && return unless User.where(activated: true)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Перевір пошту для активації аккаунту'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Профіль оновлено'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Користувача видалено'
    redirect_to users_url
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :city,
      :description,
      :password,
      :password_confirmation
    )
  end

  private

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
