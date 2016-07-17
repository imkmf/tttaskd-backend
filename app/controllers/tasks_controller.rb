class TasksController < ApplicationController
  before_filter :authenticate_request!

  def index
    @tasks = @current_user.tasks
    render json: { tasks: @tasks }
  end

  def update
    @task = Task.find(params[:id])
    if @task.user != @current_user
      render json: { errors: { task: ['Unauthorized'] }}, status: :unauthorized
    else
      @task.update_attributes!(task_params)
      render json: { task: @task }
    end
  end

  private
  def task_params
    params.require(:task).permit(:completed, :flagged)
  end
end
