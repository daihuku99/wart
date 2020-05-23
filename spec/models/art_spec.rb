require 'rails_helper'

RSpec.describe Art, type: :model do
  before do
    @user = FactryBot.create(:user)
  end
  describe 'バリデーションのテスト' do
    context 'titleカラム' do
      it '空欄でないこと' do
        user = @user
        art.title = ''
        expect(art.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Art.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
