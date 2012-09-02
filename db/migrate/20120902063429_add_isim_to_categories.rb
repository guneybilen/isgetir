class AddIsimToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :isim, :string
  end
end
