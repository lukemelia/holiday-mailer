class ApplicationController < ActionController::Base
  include HoptoadNotifier::Catcher
  include AuthenticatedSystem
  include RoleRequirementSystem

  helper :all # include all helpers, all the time
  filter_parameter_logging :password, :password_confirmation
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  
  protected
  
  # Automatically respond with 404 for ActiveRecord::RecordNotFound
  def record_not_found
    render :file => File.join(RAILS_ROOT, 'public', '404.html'), :status => 404
  end
  
  def redirect_to_people_list_showing(household)
    flash[:scroll_to] = ".#{dom_id(household)}"
    redirect_to(people_url)
  end
end

