require_relative '../spec_helper'

describe 'Bot config' do
  let :config do
    TwitterBot::BotConfig.new(test_config)
  end

  it 'can tell its consumer_key' do
    expect(config.tokens['consumer_key']).to eq 'ck'
  end

  it 'can tell its consumer_secret' do
    expect(config.tokens['consumer_secret']).to eq 'ct'
  end

  it 'can tell its access_token' do
    expect(config.tokens['access_token']).to eq 'at'
  end

  it 'can tell its access_token_secret' do
    expect(config.tokens['access_token_secret']).to eq 'ats'
  end

end