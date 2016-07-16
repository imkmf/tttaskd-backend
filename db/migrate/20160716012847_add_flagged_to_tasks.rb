class AddFlaggedToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :flagged, :boolean, default: false, null: false
  end
end
