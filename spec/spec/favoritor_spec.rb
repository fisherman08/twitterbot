require_relative '../spec_helper'

describe 'Favoritor' do
  let :favoritor do
    TwitterBot::Favoritor.new
  end

  it 'can append status_ids' do
    favoritor.add(1)
    favoritor << 2
    expect(favoritor.favorites.size).to eq 2
  end

  it 'can exclude duplicated status_ids' do
    favoritor.add(1)
    favoritor.add(1)
    expect(favoritor.favorites.size).to eq 1
  end


end