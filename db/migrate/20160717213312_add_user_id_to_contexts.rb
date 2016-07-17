class AddUserIdToContexts < ActiveRecord::Migration[5.0]
  def change
    add_reference :contexts, :user, foreign_key: true
  end
end
