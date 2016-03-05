class SlackNotifier
  def self.ping(message, channel='#activity')
    @notifier ||= Slack::Notifier.new Rails.application.secrets.slack, username: 'Datamage'
    @notifier.channel  = channel
    @notifier.ping message
  end
end
