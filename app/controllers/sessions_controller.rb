class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!, :except => [:destroy]
  
  def facebook_oauth_token_update
    access_token = build_access_token(params[:access_token], :expires_in => params[:expires_in])
    user = User.find_or_create_user_with_access_token(access_token)
    self.current_user = user
    render :json => { :location => root_url }
  end
  
  def destroy
    clear_user_cookie
    render :json => { :message => 'Logging you out.' }
  end
  
  def new
  end
end