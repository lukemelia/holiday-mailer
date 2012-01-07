class PeopleController < ApplicationController
  def index
    @households = Household.find(:all, :include => :people).sort_by &:last_name_of_first_person
  end

  def new
    @person = Person.new(params[:person])
  end

  def edit
    @person = Person.find(params[:id])
  end

  def create
    @person = Person.new(params[:person])

    if @person.save
      flash[:notice] = "#{@person.full_name} was successfully added."
      redirect_to_people_list_showing(@person.household)
    else
      render :action => "new"
    end
  end

  def update
    @person = Person.find(params[:id])

    if @person.update_attributes(params[:person])
      flash[:notice] = 'Person was successfully changed.'
      redirect_to_people_list_showing(@person.household)
    else
      render :action => "edit"
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    flash[:notice] = "#{@person.full_name} deleted."
    redirect_to_people_list_showing(@person.household)
  end
end
