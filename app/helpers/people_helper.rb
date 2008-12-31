module PeopleHelper
  def class_for_household_div(household)
    classes = []
    classes << "letter_#{household.first_letter_of_last_name_of_first_person.downcase}"
    classes << "note_sent" if household.note_sent?
    classes.join(' ')
  end
end
