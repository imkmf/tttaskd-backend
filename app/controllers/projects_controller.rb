class ProjectsController < ApplicationController
  def index
    @projects = Project.all
    render json: { projects: @projects }
  end

  def show
    @project = Project.where(id: params[:id]).first
    render json: { project: @project }
  end
end
