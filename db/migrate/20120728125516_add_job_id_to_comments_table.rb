class AddJobIdToCommentsTable < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.integer :job_id
      t.index :job_id
    end
  end

  def down
    remove_index :comments, :job_id
    remove_column :comments, :job_id
  end

end
