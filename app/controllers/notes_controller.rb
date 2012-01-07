class NotesController < ApplicationController
  def new
    @note = Note.build_new(params[:note])
    @household_notes = Note.all(:conditions => {:batch_id => params[:note][:batch_id],
                                                :household_id => params[:note][:household_id]})
  end
  
  def create
    @note = Note.new(params[:note])
    @note.sender = current_user
    
    if @note.save
      flash[:notice] = "Note was sent to #{@note.household.description}."
      redirect_to_people_list_showing(@note.household)
    else
      render :action => "new"
    end
  end
end