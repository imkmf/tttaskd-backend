# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  name         :string
#  due_at       :datetime
#  project_id   :integer
#  context_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed    :boolean          default(FALSE), not null
#  completed_at :datetime
#  flagged      :boolean          default(FALSE), not null
#
# Indexes
#
#  index_tasks_on_context_id  (context_id)
#  index_tasks_on_project_id  (project_id)
#

class Task < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :context, optional: true

  scope :inbox, -> { where(context: nil, project: nil) }
  scope :flagged, -> { where(flagged: true) }

  def overdue?
    due_at < DateTime.now
  end

  def toggle_completion!
    toggle :completed
  end

  def toggle_flag!
    toggle :flagged
  end
end
