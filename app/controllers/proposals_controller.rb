class ProposalsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    if current_user.proposals.find_by(order_id: params[:order_id])
      flash[:success] = "Заявку вже подано!"
      redirect_to proposals_url(current_user)
    else
      @proposal = current_user.proposals.build(order_id: params[:order_id]) if logged_in?
    end
  end

  def create
    @proposal = current_user.proposals.build(proposals_params)
    if @proposal.save
      flash[:success] = "Заявку створено!"
      redirect_to proposals_url(current_user)
    else
      render 'new'
    end
  end

  def destroy
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
end
