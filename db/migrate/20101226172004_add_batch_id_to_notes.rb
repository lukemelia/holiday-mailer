class AddBatchIdToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :batch_id, :integer
  end

  def self.down
    remove_column :notes, :batch_id
  end
end