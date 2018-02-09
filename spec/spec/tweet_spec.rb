require_relative '../spec_helper'

describe 'Tweet base object' do
  let :tweet do
    TwitterBot::Bot.new( test_config)
  end

  it 'can tweet string' do
    expect(tweet.tweet.is_a?(String)).to be_truthy
  end

end