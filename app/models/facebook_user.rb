class FacebookUser < ActiveRecord::Base
  set_primary_key :fb_uid
  
  def self.profile_pic_url(fb_uid)
    image_url = "https://graph.facebook.com/#{fb_uid}/picture"
    image_url << "?return_ssl_resources=1&type=square"
    image_url
  end
end