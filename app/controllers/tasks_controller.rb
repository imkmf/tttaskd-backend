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
end
