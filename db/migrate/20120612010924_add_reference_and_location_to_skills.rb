class AddReferenceAndLocationToSkills < ActiveRecord::Migration
  def change
    add_column :skills, :reference, :string
    add_column :skills, :location, :string
  end
end
