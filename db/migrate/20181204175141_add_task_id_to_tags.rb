class AddTaskIdToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :task_id, :integer
    add_index :tags, :task_id
    add_index :tags, [:id, :task_id]
  end
end
