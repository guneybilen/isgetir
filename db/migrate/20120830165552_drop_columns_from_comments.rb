class DropColumnsFromComments < ActiveRecord::Migration
  def up
    remove_column :comments, :integer_id
    remove_column :comments, :skill_id
    remove_column :comments, :job_id_id
  end

  def down
  end
end
