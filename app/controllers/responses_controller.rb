class ResponsesController < ApplicationController
  before_action :logged_in_user, only: %i[create new]
  # before_action :correct_user, only: [:new, :create]

  def new
    if User.find(params[:user_id]).responses.find_by(proposal_id: params[:proposal_id])
      flash[:success] = "Відгук вже подано!"
      redirect_to orders_url(current_user)
    else
      @response = User.find(params[:user_id]).responses.build(proposal_id: params[:proposal_id], user_id: params[:user_id]) if logged_in?
    end
  end

  def create
    @response = Response.create(responses_params)
    if @response.save
      flash[:success] = "Відгук створено!"
      redirect_to orders_url(current_user)
    else
      render 'new'
    end
  end

  private

  def responses_params
    params.require(:response).permit(
      :score,
      :content,
      :proposal_id,
      :user_id
    )
  end
end