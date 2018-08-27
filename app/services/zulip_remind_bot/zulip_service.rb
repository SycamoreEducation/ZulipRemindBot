require 'http'

module ZulipRemindBot
  module ZulipService
    def self.send(to, content)
      auth = {
        user: ZulipRemindBot.user,
        pass: ZulipRemindBot.pass
      }

      url = "#{ZulipRemindBot.url}/api/v1/messages"

      form = {
        type: 'private',
        to: to,
        content: content
      }

      HTTP.basic_auth(auth).post(url, form: form)
    end
  end
end
