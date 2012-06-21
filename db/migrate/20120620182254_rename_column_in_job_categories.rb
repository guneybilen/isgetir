class RenameColumnInJobCategories < ActiveRecord::Migration
  def self.up
      rename_column :job_categories, :skill_id, :job_id
    end

    def self.down
      rename_column :job_categories, :job_id, :skill_id
    end

end
