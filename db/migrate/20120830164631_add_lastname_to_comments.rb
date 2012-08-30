class AddLastnameToComments < ActiveRecord::Migration
  def change
    add_column :comments, :lastname, :string
  end
end
