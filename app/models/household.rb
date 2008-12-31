class Household < ActiveRecord::Base
  has_many :people, :dependent => :destroy
  has_many :notes
  
  def description
    if read_attribute(:description).blank?
      if people.all?{|p| p.last_name == last_name_of_first_person}
        people.map(&:first_name).to_sentence + " #{last_name_of_first_person}"
      else
        people.map(&:full_name).to_sentence
      end
    else
      read_attribute(:description)
    end
  end
  
  def last_name_of_first_person
    people.first.last_name || ''
  end
  
  def first_letter_of_last_name_of_first_person
    if last_name_of_first_person.present?
      last_name_of_first_person.first
    end
  end
  
  def email_list
    people.map(&:full_email_address).join(', ')
  end
  
  def greeting
    if read_attribute(:greeting).blank?
      people.map(&:first_name).to_sentence
    else
      read_attribute(:greeting).blank?
    end
  end
  
  def note_sent?
    notes_count > 0
  end
end
