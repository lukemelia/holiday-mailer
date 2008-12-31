class Note < ActiveRecord::Base
  belongs_to :household, :counter_cache => true
  belongs_to :sender, :class_name => 'User'
  
  after_save :deliver
  
  def self.build_new(params)
    note = self.new(params)
    note.to = note.household.email_list
    note.subject = APP_CONFIG[:default_subject]
    note.from = APP_CONFIG[:default_from]
    note.message = ERB.new(IO.read(Rails.root + "/config/default_body.erb")).result(binding)
    note
  end
  
protected

  def deliver
    HolidayMailer.deliver_holiday_note(self)
  end
end
