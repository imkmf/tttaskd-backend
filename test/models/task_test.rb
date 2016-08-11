require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "it can be overdue" do
    task = tasks(:task_with_overdue_due_date)
    assert task.overdue?
  end

  test "it can be completed" do
    task = tasks(:task)
    task.toggle_completion!
    assert task.completed
  end

  test "it can be flagged" do
    task = tasks(:task)
    task.toggle_flag!
    assert task.flagged
  end

  test "it can recur" do
    task = tasks(:task_with_due_date)
    task.recurring_interval = 'daily'
    task.completed = true
    task.save

    new_task = Task.last

    assert_equal task.name, new_task.name
    assert_equal (task.due_at + 1.day), new_task.due_at
  end
end
