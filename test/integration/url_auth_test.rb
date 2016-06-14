require 'test_helper'

class UrlAuthTest < ActionDispatch::IntegrationTest
  self.fixture_path = UrlAuth::Engine.root.join("test", "fixtures")
  fixtures :all
  
  HTTP_RULES = YAML::load_file(File.expand_path("../http_rules.yml",  __FILE__))
  API_RULES = YAML::load_file(File.expand_path("../api_rules.yml",  __FILE__))
  XHR_RULES = YAML::load_file(File.expand_path("../xhr_rules.yml",  __FILE__))
  
  @@rules_generator = -> url_name, url_data, &block do
    url_data["users"].each_pair do |user, user_steps|
      user_steps.each do |user_step|
        block.call(user, user_step)
      end
    end
  end
  
  API_RULES.each_pair do |url_name, url_data|
    @@rules_generator.call(url_name, url_data) do |user, user_step|
      define_method("test_api_#{url_name}_#{user}_#{user_step["method"]}".to_sym) do        
        send(user_step["method"],
          url_data["url"],
          nil,
          { UrlAuth.api_header_name => url_auth_users(user.to_sym).api_code })
        
        assert_response user_step["result"]
      end
    end
  end
  
  HTTP_RULES.each_pair do |url_name, url_data|
    @@rules_generator.call(url_name, url_data) do |user, user_step|
      define_method("test_http_#{url_name}_#{user}_#{user_step["method"]}".to_sym) do
        if user!="guest"
          post '/login', { user_name: user }
        end        
        send(user_step["method"], url_data["url"])
        
        assert_response user_step["result"]
      end
    end
  end
  
  XHR_RULES.each_pair do |url_name, url_data|
    @@rules_generator.call(url_name, url_data) do |user, user_step|
      define_method("test_xhr_#{url_name}_#{user}_#{user_step["method"]}".to_sym) do
        if user!="guest"
          post '/login', { user_name: user }
        end        
        xhr user_step["method"], url_data["url"]
        
        assert_response user_step["result"]
      end
    end
  end
end
