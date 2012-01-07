class UpdateUserColumns < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :name
  end

  def down
  end
end