class DropJobCategoriesTable < ActiveRecord::Migration
  def up
    drop_table :job_categories
  end

  def down
    create_table :job_categories
  end
end
