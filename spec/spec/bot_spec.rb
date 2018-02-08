require_relative '../spec_helper'

describe 'Bot object' do
  let :bot do
    TwitterBot::Bot.new
  end

  it 'can tweets' do
    expect(bot.tweet).not_to be ''
  end
end