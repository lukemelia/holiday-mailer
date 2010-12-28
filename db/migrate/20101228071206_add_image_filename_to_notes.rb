class AddImageFilenameToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :image_filename, :string
  end

  def self.down
    remove_column :notes, :image_filename
  end
end
