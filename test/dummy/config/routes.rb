Rails.application.routes.draw do
  mount ZulipRemindBot::Engine => "/zulip_remind_bot"
end
