class HolidayMailer < ActionMailer::Base
  def holiday_note(note)
    recipients note.to.split(/,\s*/)
    subject    note.subject
    from       note.from
    content_type "multipart/alternative"

    part "text/plain" do |p|
      p.body = render_message("holiday_note.text.plain.erb", :note => note)
      p.content_disposition = ""
      p.transfer_encoding = "7bit"
      p.charset = "ISO-8859-15"
    end
    
    part "multipart/related" do |p|
      p.headers['type'] = "text/html"
      
      p.parts << ActionMailer::Part.new(
        :content_type => "text/html", :body => render_message("holiday_note.text.html.erb", :note => note, :part_container => p),
        :disposition => "",
        :charset => "ISO-8859-15",
        :transfer_encoding => "7bit"
      )
      p.parts.reverse!
    end
  end
end