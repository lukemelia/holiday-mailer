class NotesController < ApplicationController
  before_filter :login_required
    
  def new
    @note = Note.build_new(params[:note])
  end
  
  def create
    @note = Note.new(params[:note])
    @note.sender = current_user
    
    if @note.save
      flash[:notice] = "Note was sent to #{@note.household.description}."
      flash[:scroll_to] = ".#{dom_id(@note.household)}"
      redirect_to(people_url)
    else
      render :action => "new"
    end
  end
end