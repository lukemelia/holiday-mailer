class UpdateFacebookUsersTable < ActiveRecord::Migration
  def up
    remove_column :facebook_users, :email
    add_column :facebook_users, :access_token, :text
    add_column :facebook_users, :access_token_expires, :datetime
  end

  def down
  end
end