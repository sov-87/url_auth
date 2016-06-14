require 'active_support/concern'

module UrlAuth
  module CheckAccess
    extend ActiveSupport::Concern
    
    def trying_to_login?() UrlAuth.login_urls.include?(request.path) end
    def logged_in?() session[:user_name]!=nil end
    
    def api_request?() request.headers[UrlAuth.api_header_name]!=nil end
    def not_regular_request?() request.xhr? || request.headers["Accept"]=="text/event-stream" end
      
    def get_login_path
      UrlAuth.login_path
    end
    
    def get_api_user_search_condition() { api_code: request.headers[UrlAuth.api_header_name] } end
    def get_session_user_search_condition() { name: logged_in? ? session[:user_name] : UrlAuth.guest_user_name } end
    
    def get_user
      unless defined?(@user)
        @user = UrlAuth.user_class.find_by(api_request? ? get_api_user_search_condition : get_session_user_search_condition)
      end
      
      @user
    end
    
    def check_permission user, path, http_method
      check_status = false
      
      user_urls = UrlAuth.url_class.by_user user
      check_status = user_urls.any? do |user_url|
        path[Regexp.new(user_url.url_pattern)]==path &&
        (user_url.http_method.nil? || http_method==user_url.http_method)
      end

      check_status
    end
    
    def check_access
      check_status = check_permission get_user, request.path, request.method.to_s
      
      unless check_status
        if api_request? || logged_in?
          render "url_auth/not_authorized", status: 403, locals: { res: { message: "Not authorized" } }
        elsif !trying_to_login?
          if UrlAuth.redirect_to_login && !not_regular_request?
            respond_to do |format|
              format.any(:html) { redirect_to get_login_path; return }
            end
          end
          
          render "url_auth/not_authenticated", status: 401, locals: { res: { message: "Not authenticated" } }
        end
      end
    end
  end
end
