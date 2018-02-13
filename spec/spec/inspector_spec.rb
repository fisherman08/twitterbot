require_relative '../spec_helper'

describe 'Timeline inspector' do
  let :inspector do
    TwitterBot::Inspector.new
  end

  let :dummy_tweet do
    dummy_tweet_user = (Struct.new(:screen_name, :id)).new('dummy_man', 123456)
    (Struct.new(:text, :in_reply_to_status_id, :user)).new('ほげほげ本文', nil, dummy_tweet_user)
  end

  it 'can regist inspections' do
    expect{inspector.regist(:injection , 'ほげ', 'ふが')}.to change{ inspector.inspections.size }.from(0).to(1)
  end

  it 'injects to matched tweet' do
    inspector.regist(:injection , 'ほげ', 'ふが')
    result = inspector.inspect([dummy_tweet])
    expect(result.size).to eq 1
    expect(result[0].tweet).to eq '@dummy_man ふが'
  end

  it 'does not reply to unmatched tweet' do
    inspector.regist(:injection , 'あああ', 'いいい')
    result = inspector.inspect([dummy_tweet])
    expect(result.size).to eq 0
  end

end