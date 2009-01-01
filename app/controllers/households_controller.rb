class HouseholdsController < ApplicationController
  before_filter :login_required

  def edit
    @household = Household.find(params[:id])
  end
  
  def update
    @household = Household.find(params[:id])

    if @household.update_attributes(params[:household])
      flash[:notice] = 'Household was successfully updated.'
      flash[:scroll_to] = ".#{dom_id(@household)}"
      redirect_to(people_url)
    else
      render :action => "edit"
    end
  end
end