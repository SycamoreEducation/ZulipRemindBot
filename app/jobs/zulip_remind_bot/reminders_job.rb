module ZulipRemindBot
  class RemindersJob < ApplicationJob
    queue_as :default

    def perform(to, message)
      content = "You asked me to remind you to \"#{message}\" at this time."
      ZulipService.send(to, content)
    end
  end
end
