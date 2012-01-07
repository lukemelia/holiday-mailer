class CreateUsersTable < ActiveRecord::Migration
  def self.up
    # Create Users Table
    create_table :users do |t|
      t.string :login, :limit => 40
      t.string :identity_url      
      t.string :name, :limit => 100, :default => '', :null => true
      t.string :email, :limit => 100
      t.datetime :activated_at
      t.datetime :deleted_at
      t.timestamps
    end
    
    add_index :users, :login, :unique => true
  end

  def self.down
    drop_table :users
  end
end
