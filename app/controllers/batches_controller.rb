class BatchesController < ApplicationController
  def index
    @batches = Batch.all(:order => 'created_at DESC')
  end
  
  def new
    @batch = Batch.new
    @batch.subject = APP_CONFIG[:default_subject]
    @batch.from = APP_CONFIG[:default_from]
    @batch.message = IO.read(Rails.root.join("config", "default_body.erb"))
    @batch.image_filename = APP_CONFIG[:default_image_filename]
  end
  
  def create
    Batch.create!(params[:batch])
    redirect_to :action => :index
  end
  
  def edit
    @batch = Batch.find(params[:id])
  end
  
  def update
    @batch = Batch.find(params[:id])
    if @batch.update_attributes(params[:batch])
      flash[:notice] = 'Batch updated.'
      redirect_to :action => :index
    else
      render :action => 'edit'
    end
  end
  
  def activate
    batch = Batch.find(params[:id])
    if batch.activate!
      flash[:notice] = 'Batch activated.'
    else
      flash[:error] = 'There was a problem activating this batch.'
    end
    redirect_to :action => :index
  end
end