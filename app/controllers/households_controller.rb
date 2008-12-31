class HouseholdsController < ApplicationController
  before_filter :login_required

  def edit
    @household = Household.find(params[:id])
  end
  
  def update
    @household = Household.find(params[:id])

    respond_to do |format|
      if @household.update_attributes(params[:household])
        flash[:notice] = 'Household was successfully updated.'
        format.html { redirect_to(people_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @household.errors, :status => :unprocessable_entity }
      end
    end
  end
end