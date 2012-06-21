class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :job_id
      t.string :name
      t.string :lastname
      t.string :phone
      t.string :cell
      t.string :email

      t.timestamps
    end
  end
end
