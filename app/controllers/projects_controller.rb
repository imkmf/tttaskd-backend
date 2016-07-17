class ProjectsController < ApplicationController
  before_filter :authenticate_request!

  def index
    @projects = @current_user.projects
    render json: { projects: @projects }
  end

  def show
    @project = Project.where(id: params[:id]).first
    if @project.user != @current_user
      render json: { errors: { project: ['Unauthorized'] }}, status: :unauthorized
    else
      render json: { project: @project }
    end
  end
end
