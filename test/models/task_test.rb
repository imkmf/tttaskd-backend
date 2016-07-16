require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "it can find inbox tasks" do
    dont_find_this = Task.create(name: 'Test2', project: projects(:project))
    find_this = Task.create(name: 'Test')

    inbox_tasks = Task.inbox
    assert inbox_tasks.include?(find_this)
    assert_not inbox_tasks.include?(dont_find_this)
  end

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
end
