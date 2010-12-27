class RenameNotesCount < ActiveRecord::Migration
  def self.up
    rename_column :households, :notes_count, :active_notes_count
  end

  def self.down
    rename_column :households, :active_notes_count, :notes_count
  end
end