module PeopleHelper
  def class_for_household_div(household)
    classes = []
    classes << dom_id(household)
    classes << "letter_#{household.first_letter_of_last_name_of_first_person.downcase}"
    classes << "note_sent" if household.note_sent?
    classes.join(' ')
  end
  
  def link_to_new_note(household)
    if household.notes_count == 0
      link_to "Send mail", new_note_path(:note => {:household_id => household.id})
    elsif household.notes_count == 1
      link_to "Email sent by #{household.notes.last.sender.login}", new_note_path(:note => {:household_id => household.id})
    else
      link_to "#{household.notes_count} emails sent (last by #{household.notes.last.sender.login})", new_note_path(:note => {:household_id => household.id})
    end
  end
end
