class ProjectsController < ApplicationController
  before_filter :authenticate_request!

  def index
    @projects = Project.all
    render json: { projects: @projects }
  end

  def show
    @project = Project.where(id: params[:id]).first
    render json: { project: @project }
  end
end
