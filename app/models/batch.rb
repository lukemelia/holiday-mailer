class Batch < ActiveRecord::Base
  has_many :notes

  attr_accessible :name, :subject, :from, :message, :image_filename

  def self.active_batch
    Batch.where(active: true).first
  end

  def activate!
    transaction do
      Batch.update_all(:active => true, :active => false)
      update_attribute(:active, true)
      Household.all.each do |h|
        h.update_active_notes_count
      end
    end
  end
end
