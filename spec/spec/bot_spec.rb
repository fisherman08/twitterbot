require_relative '../spec_helper'

describe 'Bot object' do
  let :bot do
    TwitterBot::Bot.new(test_config)
  end

  let :my_user do
    (Struct.new(:screen_name, :id)).new('myself', 1)
  end

  let :twitter_client_mock do
    double('Twitter client')
  end


  before do
    allow(twitter_client_mock).to receive(:user).and_return(my_user)
    allow(bot).to receive(:twitter_client).and_return(twitter_client_mock)
  end

  it 'can get timeline' do
    sample_timeline = [
      dummy_tweet.new('収集の対象になるツイート', nil, dummy_tweet_user, 666, Twitter::NullObject.new),
      dummy_tweet.new('RTだから無視されるツイート', nil, dummy_tweet_user, 667, {}),
      dummy_tweet.new('自分のツイートだから無視される', nil, my_user, 668, Twitter::NullObject.new)
    ]
    expect(twitter_client_mock).to receive(:home_timeline).and_return(sample_timeline)

    expect(bot.home_timeline.size).to eq 1
  end

  it 'can inject' do
    expect(twitter_client_mock).to receive(:home_timeline).and_return([dummy_tweet.new('せんだ', nil, dummy_tweet_user, 666, Twitter::NullObject.new)])
    expect(twitter_client_mock).to receive(:update)

    bot.regist_inspection([{'key' => 'せんだ', 'text' => 'みつお'}])
    bot.inspect
    expect(bot.tweet).to eq 1
  end

  it 'can save and read the status id read already' do
    bot.reset_status
    bot.save_status(123456)
    expect(bot.last_status).to eq 123456
    bot.reset_status
  end


end