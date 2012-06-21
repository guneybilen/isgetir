class AddReferenceAndLocationToSkills < ActiveRecord::Migration
  def change
    add_column :jobs, :reference, :string
    add_column :jobs, :location, :string
  end
end
