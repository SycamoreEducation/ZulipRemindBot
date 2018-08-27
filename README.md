# ZulipRemindBot
Ruby on Rails engine for Zulip reminders

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'zulip_remind_bot', git: 'https://github.com/SycamoreEducation/ZulipRemindBot'
```

And then execute:
```bash
$ bundle
```

Mount in your routes config:
```ruby
Rails.application.routes.draw do
  mount ZulipRemindBot::Engine => '/reminders'
```

Set up an [Outgoing Webhook bot](https://zulipchat.com/api/outgoing-webhooks) in Zulip pointing to this new route.

Create `config/initializers/zulip_remind_bot.rb` to populate the bot's credentials and other configuration values:
```ruby
ZulipRemindBot.user = 'user@example.com'
ZulipRemindBot.pass = ''
ZulipRemindBot.token = ''
ZulipRemindBot.url = 'https://zulip.example.com'
ZulipRemindBot.tz = 'US/Central'
```

## Usage
Send a private message to your Zulip bot with the syntax `<msg> | <time>` to set a reminder.
```
go home | at 5pm
take a break | in 20 minutes
```

Times are parsed by the Chronic gem. See the [README](https://github.com/mojombo/chronic) for examples.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
