class Note < ActiveRecord::Base
  belongs_to :household
  belongs_to :sender, :class_name => 'User'
  
  after_save :deliver
  after_create :update_household_notes_count
  
  def self.build_new(params)
    note = self.new(params)
    note.to = note.household.email_list
    batch = Batch.active_batch
    note.subject = batch.subject || APP_CONFIG[:default_subject]
    note.from = batch.from || APP_CONFIG[:default_from]
    note.image_filename = batch.image_filename || APP_CONFIG[:default_image_filename]
    note.message = (batch.message || IO.read(Rails.root + "/config/default_body.erb")).gsub('__GREETING__', note.household.greeting)
    note
  end
  
protected

  def deliver
    HolidayMailer.deliver_holiday_note(self)
  end
  
  def update_household_notes_count
    household.update_active_notes_count
  end
end
