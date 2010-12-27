class RequireBatchIdOnNotes < ActiveRecord::Migration
  def self.up
    change_column :notes, :batch_id, :integer, :null => false
  end

  def self.down
    change_column :notes, :batch_id, :string, :null => true
  end
end