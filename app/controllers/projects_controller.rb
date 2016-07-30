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

  def create
    cp = project_params.to_h
    cp[:user_id] = @current_user.id

    @project = Project.new(cp)
    if @project.valid?
      @project.save!
      render json: { project: @project }
    else
      render json: { errors: @project.errors }
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.user != @current_user
      render json: { errors: { project: ['Unauthorized'] }}, status: :unauthorized
    else
      @project.update_attributes!(project_params)
      render json: { project: @project }
    end
  end

  private
  def project_params
    params.require(:project).permit(
      :name,
      :notes,
    )
  end
end
