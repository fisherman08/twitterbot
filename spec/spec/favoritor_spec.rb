require_relative '../spec_helper'

describe 'Favoritor' do
  let :favoritor do
    TwitterBot::Favoritor.new
  end

  it 'can append status_ids' do
    favoritor.add({id: 1})
    favoritor << {id: 2}
    expect(favoritor.favorites.size).to eq 2
  end

  it 'can exclude duplicated status_ids' do
    favoritor.add({id: 1})
    favoritor.add({id: 1})
    expect(favoritor.favorites.size).to eq 1
  end

  it 'can regist keys' do
    favoritor.regist_keys(['hoge', 'fuga'])
    favoritor.regist_keys('nerima')

    expect(favoritor.key_size). to eq 3
  end


end