class AddInitialBatch < ActiveRecord::Migration
  class Batch < ActiveRecord::Base; end
  class Note < ActiveRecord::Base; end
  
  def self.up
    transaction do
      batch = Batch.create! do |b|
        b.name = "Initial batch"
        b.subject = APP_CONFIG[:default_subject]
        b.from = APP_CONFIG[:default_from]
        b.message = IO.read(Rails.root + "/config/default_body.erb")
        b.image_filename = 'happy-new-year-2008-9.jpg'
        b.active = true
      end
      Note.update_all(:batch_id => batch.id)
    end
  end

  def self.down
    Batch.find_by_name('Initial batch').destroy
  end
end
