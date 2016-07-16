class ContextsController < ApplicationController
  def index
    @contexts = Context.all
    render json: { contexts: @contexts }
  end

  def show
    @context = Context.where(id: params[:id]).first
    render json: { context: @context }
  end
end
