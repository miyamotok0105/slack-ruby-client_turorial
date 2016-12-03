require 'slack-ruby-client'
require 'dotenv'
Dotenv.load

Slack.configure do |config|
    config.token = ENV['SLACK_API_TOKEN']
    fail 'Missing ENV[SLACK_API_TOKEN]! Please set up .env.' unless config.token
end


client = Slack::Web::Client.new

channel = client.channels_list['channels'].detect{ |u| u['name'] == ARGV[0] }

if channel.nil?
    puts "I can not find this channel. Please confirm that this channel exist."
else
    puts channel['id']
end

