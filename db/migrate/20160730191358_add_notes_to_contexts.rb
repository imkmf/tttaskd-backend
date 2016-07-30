class AddNotesToContexts < ActiveRecord::Migration[5.0]
  def change
    add_column :contexts, :notes, :text
  end
end
