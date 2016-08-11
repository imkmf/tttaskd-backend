class TasksController < ApplicationController
  before_filter :authenticate_request!

  def index
    @tasks = @current_user.tasks
    render json: { tasks: @tasks }
  end

  def create
    tp = task_params.to_h
    tp[:user_id] = @current_user.id

    @task = Task.new(tp)
    if @task.valid?
      @task.save!
      render json: { task: @task }
    else
      render json: { errors: @task.errors }
    end
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
    params.require(:task).permit(
      :completed,
      :context_id,
      :due_at,
      :flagged,
      :name,
      :notes,
      :project_id,
      :recurring_interval,
    )
  end
end
