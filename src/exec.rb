require_relative './lib/twitterbot/twitter_bot'
require 'pp'
require 'yaml'

begin
  configs = YAML.load_file(File.expand_path(File.dirname(__FILE__)) + '/../config/config.yml')

  configs[:rest].each do |client|
    bot = TwitterBot::Bot.new(client[:keys])
    bot.regist_inspection(client[:inspection])
    bot.inspect
    bot.tweet
  end

rescue => e
  pp e.message

end
