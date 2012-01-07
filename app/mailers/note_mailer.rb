class NoteMailer < ActionMailer::Base
  def holiday_note(note)
    @note = note
    data = File.read(Rails.root.join("app", "assets", "images", @note.image_filename))
    attachments.inline[@note.image_filename] = data
    mail(:to => @note.to, :subject => @note.subject, :from => @note.from)
  end
end