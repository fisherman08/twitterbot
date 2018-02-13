require_relative '../spec_helper'

describe 'Bot object' do
  let :bot do
    TwitterBot::Bot.new(test_config)
  end

  let :my_user do
    (Struct.new(:screen_name, :id)).new('myself', 1)
  end

  it 'can get timeline' do
    sample_timeline = [
      dummy_tweet.new('収集の対象になるツイート', nil, dummy_tweet_user, 666, nil),
      dummy_tweet.new('RTだから無視されるツイート', nil, dummy_tweet_user, 667, {}),
      dummy_tweet.new('自分のツイートだから無視される', nil, my_user, 668, nil)
    ]
    twitter_client_mock = double('Twitter client')
    expect(twitter_client_mock).to receive(:home_timeline).and_return(sample_timeline)
    expect(twitter_client_mock).to receive(:user).and_return(my_user)
    allow(bot).to receive(:twitter_client).and_return(twitter_client_mock)

    expect(bot.home_timeline.size).to eq 1
  end

  it 'can inject' do
    twitter_client_mock = double('Twitter client')
    expect(twitter_client_mock).to receive(:home_timeline).and_return([dummy_tweet.new('せんだ', nil, dummy_tweet_user, 666, nil)])
    expect(twitter_client_mock).to receive(:user).and_return(my_user)
    expect(twitter_client_mock).to receive(:update)
    allow(bot).to receive(:twitter_client).and_return(twitter_client_mock)

    bot.regist_inspection([{'key' => 'せんだ', 'text' => 'みつお'}])
    bot.inspect
    expect(bot.tweet).to eq 1
  end



end