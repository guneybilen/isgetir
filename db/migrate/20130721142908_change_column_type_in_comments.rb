class ChangeColumnTypeInComments < ActiveRecord::Migration
  def up
    change_column :comments, :body, :string, :limit => 1000
  end

  def down
    change_column :comments, :body, :text
  end
end
