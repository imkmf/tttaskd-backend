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
      if @task.completed == false && task_params[:completed] == true
        if @task.recurring_interval
          new_due_at = @task.due_at ?
            (@task.due_at + @task.recurring_interval_as_date) : nil
          @next_task = Task.create(
            name: @task.name,
            due_at: new_due_at,
            project: @task.project,
            context: @task.context,
            user: @task.user,
            notes: @task.notes,
            recurring_interval: @task.recurring_interval,
          )

          @task.next_task = @next_task
        end
      end

      @task.update_attributes!(task_params)
      render json: { task: @task }
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.user != @current_user
      render json: { errors: { task: ['Unauthorized'] }}, status: :unauthorized
    else
      @task.destroy
      render json: "", status: :ok
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
