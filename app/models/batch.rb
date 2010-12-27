class Batch < ActiveRecord::Base
  has_many :notes
  
  attr_accessible :name, :subject, :from, :message
  
  def self.active_batch
    Batch.first(:conditions => { :active => true })
  end
  
  def activate!
    transaction do
      Batch.update_all(:active => true, :active => false)
      update_attribute(:active, true)
      Household.paginated_each do |h|
        h.update_active_notes_count
      end
    end
  end
end