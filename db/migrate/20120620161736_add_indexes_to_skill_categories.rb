class AddIndexesToSkillCategories < ActiveRecord::Migration
  def change
    add_index :skill_categories, ['skill_id', 'category_id']
  end
end
