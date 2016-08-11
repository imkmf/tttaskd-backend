class AddRecurringToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :recurring_interval, :string
  end
end
