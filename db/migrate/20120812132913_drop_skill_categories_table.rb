class DropSkillCategoriesTable < ActiveRecord::Migration
  def change
    remove_index :skill_categories, ['skill_id', 'category_id']
    drop_table :skill_categories
  end
end
