class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :due_at
      t.belongs_to :project, foreign_key: true
      t.belongs_to :context, foreign_key: true

      t.timestamps
    end
  end
end
