require_relative '../spec_helper'

describe 'Bot config' do
  let :config do
    TwitterBot::BotConfig.new(999, {})
  end

  it 'can tell its user_id' do
    expect(config.user_id).to be 999
  end
end