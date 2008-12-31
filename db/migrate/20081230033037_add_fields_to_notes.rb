class AddFieldsToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :household_id, :integer
    add_column :notes, :sender_id, :integer
    add_column :notes, :from, :string
    add_column :notes, :subject, :string
  end

  def self.down
    remove_column :notes, :household_id
    remove_column :notes, :sender_id
    remove_column :notes, :from
    remove_column :notes, :subject
  end
end
