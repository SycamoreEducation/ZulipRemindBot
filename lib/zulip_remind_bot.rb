require "zulip_remind_bot/engine"

module ZulipRemindBot
  mattr_accessor :user
  mattr_accessor :pass
  mattr_accessor :token
  mattr_accessor :url
  mattr_accessor :tz
end
