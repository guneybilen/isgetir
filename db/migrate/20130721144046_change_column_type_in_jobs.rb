class ChangeColumnTypeInJobs < ActiveRecord::Migration
  def up
    change_column :jobs, :body, :string, :limit => 3000
  end

  def down
    change_column :jobs, :body, :text
  end
end
