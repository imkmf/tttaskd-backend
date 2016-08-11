# == Schema Information
#
# Table name: tasks
#
#  id                 :integer          not null, primary key
#  name               :string
#  due_at             :datetime
#  project_id         :integer
#  context_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  completed          :boolean          default(FALSE), not null
#  completed_at       :datetime
#  flagged            :boolean          default(FALSE), not null
#  user_id            :integer
#  notes              :text
#  recurring_interval :string
#  next_task_id       :integer
#
# Indexes
#
#  index_tasks_on_context_id    (context_id)
#  index_tasks_on_next_task_id  (next_task_id)
#  index_tasks_on_project_id    (project_id)
#  index_tasks_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_02e851e3b7  (project_id => projects.id)
#  fk_rails_4d2a9e4d7e  (user_id => users.id)
#  fk_rails_6a2e669e50  (context_id => contexts.id)
#

class Task < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :project, optional: true
  belongs_to :context, optional: true
  belongs_to :user
  has_one :next_task, class_name: 'Task', foreign_key: 'next_task_id'

  scope :inbox, -> { where(context: nil, project: nil) }
  scope :flagged, -> { where(flagged: true) }

  validates_inclusion_of :recurring_interval, in: %w( daily weekly monthly )

  def overdue?
    due_at < DateTime.now
  end

  def toggle_completion!
    toggle :completed
  end

  def toggle_flag!
    toggle :flagged
  end

  def recurring_interval_as_date
    case recurring_interval
    when "daily"
      1.day
    when "weekly"
      1.week
    when "monthly"
      1.month
    else
      nil
    end
  end

  def create_next_in_recurring!
    return unless recurring_interval
    new_due_at = due_at + recurring_interval_as_date

    new_task = Task.create(
      name: name,
      due_at: new_due_at,
      project: project,
      context: context,
      user: user,
      notes: notes,
      recurring_interval: recurring_interval,
    )

    self.next_task = new_task
  end

  def save
    if completed_changed?(from: false, to: true)
      create_next_in_recurring!
    end

    super
  end
end
