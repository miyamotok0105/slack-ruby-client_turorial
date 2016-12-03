
require 'slack-ruby-client'
require 'dotenv'
Dotenv.load

Slack.configure do |config|
    config.token = ENV['SLACK_API_TOKEN']
    fail 'Missing ENV[SLACK_API_TOKEN]! Please set up .env.' unless config.token
end

# RTM Clientのインスタンス生成
client = Slack::RealTime::Client.new

# slackに接続できたときの処理
client.on :hello do
  puts 'connected!'
end

# message eventを受け取った時の処理
client.on :message do |data|
  case data['text']
  when 'にゃーん' then
    # textが 'にゃーん' だったらそのチャンネルに 'Λ__Λ' を投稿
    client.message channel: data['channel'], text:'Λ__Λ'
  end

  if data['text'].include?('こんにちは')
    client.message channel: data['channel'], text: "Hi!"
  end
  if data['text'].include?('かしこい') || data['text'].include?('えらい')
    client.message channel: data['channel'], text: "Thank you!"
  end
  if data['text'].include?('おやすみ')
    client.message channel: data['channel'], text: "Good night"
  end

end

client.on :close do |_data|
  puts "Client is about to disconnect"
end

client.on :closed do |_data|
  puts "Client has disconnected successfully!"
end

client.start!

