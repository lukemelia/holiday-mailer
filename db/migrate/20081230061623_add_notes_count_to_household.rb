class AddNotesCountToHousehold < ActiveRecord::Migration
  def self.up
    add_column :households, :notes_count, :integer, :default => 0
  end

  def self.down
    remove_column :households, :notes_count
  end
end
