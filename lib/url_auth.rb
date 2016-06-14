require "url_auth/engine"
require "url_auth/validators/regexp_validator"

module UrlAuth
  mattr_accessor :api_header_name,
    :guest_user_name,
    :login_urls,
    :login_path,
    :redirect_to_login,
    :user_class,
    :url_class
  
  def self.user_class
    @@user_class.constantize
  end
  
  def self.url_class
    @@url_class.constantize
  end
  
  @@api_header_name = "HTTP_API_CODE"
  @@guest_user_name = "guest"
  @@login_urls = ["/login"]
  @@login_path = "/login"
  @@redirect_to_login = true
  @@user_class = 'UrlAuth::User'
  @@url_class = 'UrlAuth::Url'
end
