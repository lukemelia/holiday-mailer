class CreateHouseholds < ActiveRecord::Migration
  def self.up
    create_table :households do |t|
      t.string :description
      t.string :greeting

      t.timestamps
    end
  end

  def self.down
    drop_table :households
  end
end
