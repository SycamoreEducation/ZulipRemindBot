require 'chronic'

module ZulipRemindBot
  class Controller < ApplicationController
    def create
      data = JSON.parse(request.raw_post)

      head :unauthorized if data['token'] != ZulipRemindBot.token

      Time.zone = ZulipRemindBot.tz
      Chronic.time_class = Time.zone

      to = data['message']['sender_email']
      parts = data['message']['content'].split('|')
      message = parts.first.strip
      time_str = parts.second.strip
      time_str = "today #{time_str}" if time_str =~ /^at/
      time = Chronic.parse(time_str)

      RemindersJob.set(wait_until: time).perform_later(to, message)

      human_time = time.strftime('%A, %b %e at %l:%M%p')

      ZulipService.send(to, "Reminder scheduled for #{human_time}.")

      head :no_content
    end
  end
end
