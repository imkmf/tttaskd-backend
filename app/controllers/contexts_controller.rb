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

  def create
    cp = context_params.to_h
    cp[:user_id] = @current_user.id

    @context = Context.new(cp)
    if @context.valid?
      @context.save!
      render json: { context: @context }
    else
      render json: { errors: @context.errors }
    end
  end

  def update
    @context = Context.find(params[:id])
    if @context.user != @current_user
      render json: { errors: { context: ['Unauthorized'] }}, status: :unauthorized
    else
      @context.update_attributes!(context_params)
      render json: { context: @context }
    end
  end

  private
  def context_params
    params.require(:context).permit(
      :name,
    )
  end
end
