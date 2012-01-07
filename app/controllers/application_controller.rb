class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  helper_method :current_user, :current_user?
  def build_access_token(the_token, opts = {})
    oauth_client = OAuth2::Client.new(FACEBOOK[:app_id], FACEBOOK[:app_secret], {
      :site => 'https://graph.facebook.com',
      :raise_errors => false
    })
    access_token = OAuth2::AccessToken.new(oauth_client, the_token, opts)
    access_token.options[:mode] = :query
    access_token.options[:param_name] = :access_token
    access_token
  end
  
  def authenticate_user!
    return true if current_user?
    redirect_to login_url
  end
  
  def current_user
    @current_user ||= User.authenticate(cookies[User.cookie_name])
  end
  
  def current_user?
    current_user != nil
  end

  def current_user=(user)
    @current_user = user
    set_user_cookie(user)
  end
  
  def cookie_domain
    APP_CONFIG[:site_url].gsub(/^http:\/\//, '')
  end
  
  def set_user_cookie(user)
    cookies.permanent[User.cookie_name] = { :value => user.id,
                                            :httponly => true,
                                            # :secure => true,
                                            :domain => cookie_domain,
                                            :path => '/' }
  end
  
  def clear_user_cookie
    cookies.delete(User.cookie_name, :domain => cookie_domain,
                                     :path => '/')
  end
  
  def redirect_to_people_list_showing(household)
    flash[:scroll_to] = ".#{dom_id(household)}"
    redirect_to(people_url)
  end
end
