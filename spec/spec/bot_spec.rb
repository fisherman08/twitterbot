require_relative '../spec_helper'

describe 'Bot object' do
  let :bot do
    TwitterBot::Bot.new( test_config)
  end

  it 'can tweets' do
    expect(bot.tweet).not_to be ''
  end

  it 'can regist injections' do

  end
end