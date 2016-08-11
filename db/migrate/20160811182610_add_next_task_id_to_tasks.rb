class AddNextTaskIdToTasks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :next_task
  end
end
