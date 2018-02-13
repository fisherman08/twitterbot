require_relative '../spec_helper'

describe 'Tweet base object' do
  let :tweet do
    TwitterBot::Tweet.new(text: 'hoge', in_reply_to_status_id: 456)
  end

  it 'can tweet string' do
    expect(tweet.tweet).to eq 'hoge'
  end

end