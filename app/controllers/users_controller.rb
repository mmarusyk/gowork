class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy orders proposals]
  before_action :correct_user, only: %i[edit update orders orders proposals]
  before_action :admin_user, only: :destroy

  def index
    # @users = User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'Користувача видалено'
    redirect_to users_url
  end

  def orders
    @user = User.find(params[:id])
    if params[:status] == 'Активне'
      @orders = @user.orders.where('status = ? and duedate >=?', params[:status], Time.now).paginate(page: params[:page], per_page: 20)
    elsif params[:status] == 'Виконується' || params[:status] == 'Завершене'
      @orders = @user.orders.where('status = ?', params[:status]).paginate(page: params[:page], per_page: 20)
    elsif params[:status] == 'timeend'
      @orders = @user.orders.where('duedate < ?', Time.now).paginate(page: params[:page], per_page: 20)
    else
      @orders = @user.orders.where('status = ? and duedate >=?', 'Активне', Time.now).paginate(page: params[:page], per_page: 20)
    end
  end

  def proposals
    @user = User.find(params[:id])
    @proposals = @user.proposals.paginate(page: params[:page], per_page: 20)
  end

  private

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

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
