class PeopleController < ApplicationController
  before_filter :login_required
  
  def index
    @households = Household.find(:all, :include => :people).sort_by &:last_name_of_first_person
  end

  def show
    @person = Person.find(params[:id])
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
      flash[:notice] = "#{@person.full_name} was successfully created."
      flash[:scroll_to] = ".#{dom_id(@person.household)}"
      redirect_to(people_url)
    else
      render :action => "new"
    end
  end

  def update
    @person = Person.find(params[:id])

    if @person.update_attributes(params[:person])
      flash[:notice] = 'Person was successfully updated.'
      flash[:scroll_to] = ".#{dom_id(@person.household)}"
      redirect_to(people_url)
    else
      render :action => "edit"
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    flash[:notice] = "#{@person.full_name} deleted."
    flash[:scroll_to] = ".#{dom_id(@person.household)}"
    redirect_to(people_url)
  end
end
