class TasksController < ApplicationController
  def index
    @tasks = Task.all
    render json: { tasks: @tasks }
  end

  def inbox
    @tasks = Task.inbox
    render json: { tasks: @tasks }
  end

  def flagged
    @tasks = Task.flagged
    render json: { tasks: @tasks }
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes!(task_params)
    render json: { task: @task }
  end

  private
  def task_params
    params.require(:task).permit(:completed, :flagged)
  end
end
