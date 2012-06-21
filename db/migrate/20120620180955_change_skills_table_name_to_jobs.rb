class ChangeSkillsTableNameToJobs < ActiveRecord::Migration
  def self.up
      rename_table :skills, :jobs
    end

    def self.down
      rename_table :jobs, :skills
    end
end
