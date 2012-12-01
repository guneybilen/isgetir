class Addindex < ActiveRecord::Migration
  def up
    add_index :jobs, [:category_id, :user_id]
    #   add_index :comments, :job_id  'already existed' error verdi
    add_index :references, :job_id
    add_index :profiles, :user_id
  end

  def down
    remove_index :jobs, :column => [:category_id, :user_id]
    #   remove_index :comments, :job_id
    remove_index :references, :job_id
    remove_index :profiles, :user_id
  end
end
