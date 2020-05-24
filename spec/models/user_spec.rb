require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'アソシエーションのテスト' do
    context 'Artモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:arts).macro).to eq :has_many
      end
    end
  end
end
