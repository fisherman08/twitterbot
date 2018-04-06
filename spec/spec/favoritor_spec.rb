require_relative '../spec_helper'

describe 'Favoritor' do
  let :favoritor do
    TwitterBot::Favoritor.new
  end
  

  it 'can regist keys' do
    favoritor.regist_keys(['hoge', 'fuga'])
    favoritor.regist_keys('nerima')

    expect(favoritor.key_size). to eq 3
  end

  it 'can fav tweets matched to keys' do
    favoritor.regist_keys(['hoge'])
    favoritor.regist_keys('single')
    favoritor.add(
      [dummy_tweet.new('hoge', nil, dummy_tweet_user, 666),
       dummy_tweet.new('fuga', nil, dummy_tweet_user, 667),
       dummy_tweet.new('hoge', nil, dummy_tweet_user, 667),
       dummy_tweet.new('single', nil, dummy_tweet_user, 668),
       dummy_tweet.new('double', nil, dummy_tweet_user, 669),
      ]
    )
    expect(favoritor.favorites.size).to eq 3
  end


end