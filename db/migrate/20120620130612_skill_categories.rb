class SkillCategories < ActiveRecord::Migration
  def up
    create_table :skill_categories do |t|
      t.references :job
      t.references :category

      t.timestamps
    end
  end

  def down
    drop_table :skill_categories
  end
end
