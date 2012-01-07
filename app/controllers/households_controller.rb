class HouseholdsController < ApplicationController
  def edit
    @household = Household.find(params[:id])
  end
  
  def update
    @household = Household.find(params[:id])

    if @household.update_attributes(params[:household])
      flash[:notice] = 'Household was successfully updated.'
      redirect_to_people_list_showing(@household)
    else
      render :action => "edit"
    end
  end
end