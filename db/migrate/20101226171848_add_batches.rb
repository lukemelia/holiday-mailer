class AddBatches < ActiveRecord::Migration
  def self.up
    create_table :batches, :force => true do |t|
      t.string :name, :limit => 25
      t.string :subject, :limit => 255
      t.string :from, :limit => 255
      t.string :image_filename
      t.text :message
      t.boolean :active, :null => false, :default => false
      t.timestamps
    end
    add_index :batches, :name, :unique => true
    add_index :batches, :active
  end

  def self.down
    remove_index :batches, :column => :name
    drop_table :batches
  end
end