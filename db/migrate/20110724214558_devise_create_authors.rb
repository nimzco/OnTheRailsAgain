class DeviseCreateAuthors < ActiveRecord::Migration
  def self.up
    create_table(:authors) do |t|

      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.string :name, :unique => true
      t.timestamps
    end

    add_index :authors, :email,                :unique => true
    add_index :authors, :reset_password_token, :unique => true
    # add_index :authors, :confirmation_token,   :unique => true
    # add_index :authors, :unlock_token,         :unique => true
    # add_index :authors, :authentication_token, :unique => true
  end

  def self.down
    drop_table :authors
  end
end
