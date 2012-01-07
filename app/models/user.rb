class User < ActiveRecord::Base
  has_one :facebook_user, :foreign_key => 'fb_uid', :primary_key => 'fb_uid'
  
  def self.cookie_name
    'holiday_mailer_user_id'
  end
  
  def self.authenticate(candidate_id)
    begin
      user = find_by_id(candidate_id)
      # return nil if user && user.deauthorized?
      user
    rescue ActiveRecord::StatementInvalid => e
      if e.message =~ /PGError: ERROR:  invalid input syntax for uuid/
        nil
      end
    end
  end
  
  def self.find_or_create_user_with_access_token(access_token)
    facebook_data = access_token.get('/me', {:parse => :json}).parsed
    
    transaction do
      facebook_user = FacebookUser.find_by_fb_uid(facebook_data['id']) || FacebookUser.new
      facebook_user.tap do |fbu|
        facebook_user.fb_uid = facebook_data['id']
        facebook_user.access_token = access_token.token
        if access_token.expires_at.nil? || access_token.expires_at == '0'
          facebook_user.access_token_expires = 20.years.from_now
        else
          facebook_user.access_token_expires = Time.at(access_token.expires_at.to_i)
        end
      end.save!

      user = User.find_by_fb_uid(facebook_data['id'])
      user = User.find_by_email(facebook_data['email'])
      
      # Current solution for authorizing users is to add them to the DB with the same email address as is on record with Facebook. If they have been added, fail hard.
      raise 'User is not Authorized' if user.nil?
        
      user.tap do |u|
        user.fb_uid = facebook_data['id']
        user.first_name = facebook_data['first_name']  unless user.first_name.present?
        user.last_name  = facebook_data['last_name']   unless user.last_name.present?
        user.email      = facebook_data['email']       unless user.email.present?
        #user.deauthorized_at = nil # in case the user had previously deauthorized his account
      end.save!
      return user
    end
  end
end