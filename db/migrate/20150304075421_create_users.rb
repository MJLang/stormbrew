class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :password_digest
      t.string :display_name
      t.integer :login_count, default: 0
      t.datetime :last_login
      t.string :password_reset_token
      t.datetime :reset_token_issued_at

      t.timestamps null: false
    end

    add_index :users, :password_reset_token
    add_index :users, :email
  end
end
