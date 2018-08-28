require 'chronic'

module ZulipRemindBot
  class Controller < ApplicationController
    def create
      data = JSON.parse(request.raw_post)

      return head :unauthorized if data['token'] != ZulipRemindBot.token

      Time.zone = ZulipRemindBot.tz
      Chronic.time_class = Time.zone

      @to = data['message']['sender_email']
      parts = data['message']['content'].split('|')

      return unparseable if parts.count != 2

      message = parts.first.strip
      time_str = parts.second.strip
      time_str = "today #{time_str}" if time_str =~ /^at/
      time = Chronic.parse(time_str)

      return unparseable if time.nil?

      RemindersJob.set(wait_until: time).perform_later(@to, message)

      human_time = time.strftime('%A, %b %e at %l:%M%p')

      ZulipService.send(@to, "Reminder scheduled for #{human_time}.")

      head :no_content
    end

    private
      def unparseable
        ZulipService.send(@to, <<~STR)
          Your request could not be parsed. Here are some valid examples:
          * `go home | at 5pm`
          * `have lunch | thursday at noon`
          * `do something | in 5 minutes`
        STR
        head :accepted
      end
  end
end
