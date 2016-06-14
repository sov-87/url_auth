$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "url_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "url_auth"
  s.version     = UrlAuth::VERSION
  s.authors     = ["sov-87"]
  s.email       = ["afetisov87@gmail.com"]
  s.homepage    = "http://github.com/sov-87/url_auth"
  s.summary     = "Url-based authorization system"
  s.description = "Simple authorization system based on checking url path and http method."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "rails"
  s.add_development_dependency "sqlite3"
end
