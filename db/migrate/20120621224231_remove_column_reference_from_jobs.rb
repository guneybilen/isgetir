class RemoveColumnReferenceFromJobs < ActiveRecord::Migration
  def up
    remove_column :jobs, :reference
  end

  def down
    add_column :jobs, :reference
  end
end
