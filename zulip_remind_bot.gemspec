$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "zulip_remind_bot/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zulip_remind_bot"
  s.version     = ZulipRemindBot::VERSION
  s.authors     = ["Jeremiah A. Bohling"]
  s.email       = ["jbohling@sycamoreleaf.com"]
  s.summary     = "Rails Engine for Zulip Reminders"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1"
  s.add_dependency "http"
  s.add_dependency "chronic"
end
