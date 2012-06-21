class ChangeSkillCategoriesTableNameToJobsCategories < ActiveRecord::Migration
 def self.up
   rename_table :skill_categories, :job_categories
  end

  def self.down
   rename_table :job_categories, :skill_categories
  end
end
