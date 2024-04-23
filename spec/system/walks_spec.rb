require 'rails_helper'

RSpec.describe 'Walks', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  it '歩行開始時に歩行記録が作られる' do
    expect do
      start_walk
    end.to change { Walk.count }.by(1)
  end

  it '歩行開始時に歩行の情報が表示される' do
    start_walk
    expect(page).to have_content('出発から：0時間0分')
    expect(page).to have_content('歩いた駅：0駅（残り30駅）')
    expect(page).to have_content('歩いた距離：約0.0km（残り34.5km）')
  end

  it '到着後に現在の駅を更新する' do
    start_walk
    expect(page).to have_content('現在の駅 ：品川駅')
    click_on '到着'
    click_on '地図に戻る'
    expect(page).to have_content('現在の駅 ：大崎駅')
  end
end
