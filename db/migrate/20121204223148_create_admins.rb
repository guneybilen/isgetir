class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email
      t.string :hashed_password
      t.string :password_reset_token
      t.string :password_reset_sent_at
      t.string :salt
      t.string :auth_token

      t.timestamps
    end
  end
end
