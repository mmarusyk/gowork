class ProposalsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: %i[destroy update edit]

  def new
    if current_user.proposals.find_by(order_id: params[:order_id])
      flash[:success] = "Заявку вже подано!"
      redirect_to user_proposals_url(current_user)
    else
      @proposal = current_user.proposals.build(order_id: params[:order_id]) if logged_in?
    end
  end

  def create
    @proposal = current_user.proposals.build(proposals_params)
    if @proposal.save
      flash[:success] = "Заявку створено!"
      redirect_to user_proposals_url(current_user)
    else
      render 'new'
    end
  end

  def edit
    @proposal = current_user.proposals.find_by(id: params[:id])
  end

  def update
    if @proposal.update(proposals_params)
      flash[:success] = 'Дані заявки оновлено'
      redirect_to user_proposals_url(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @proposal.destroy
    flash[:success] = 'Заявку видалено'
    redirect_to request.referrer || proposals_url(current_user)
  end

  def choose_proposal
    @proposal = Proposal.find_by(id: params[:id])
    @order = Order.find_by(id: @proposal.order_id)
    proposals = Proposal.where('order_id = ? and id != ?', @proposal.order_id, @proposal.id)
    proposals.each do |proposal|
      proposal.destroy
    end
    @order.status = 'Виконується'
    @order.save
    redirect_to request.referrer || orders_url(current_user)
  end

  private

    def proposals_params
      params.require(:proposal).permit(
        :content,
        :price,
        :duedate,
        :order_id
      )
    end

    def correct_user
      if current_user.admin?
        @proposal = Proposal.find_by(id: params[:id])
      else
        @proposal = current_user.proposals.find_by(id: params[:id])
      end
      redirect_to user_proposals_url(current_user) if @proposal.nil?
    end
end
