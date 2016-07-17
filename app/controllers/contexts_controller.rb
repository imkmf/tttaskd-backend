class ContextsController < ApplicationController
  before_filter :authenticate_request!

  def index
    @contexts = @current_user.contexts
    render json: { contexts: @contexts }
  end

  def show
    @context = Context.where(id: params[:id]).first
    if @context.user != @current_user
      render json: { errors: { project: ['Unauthorized'] }}, status: :unauthorized
    else
      render json: { context: @context }
    end
  end
end
