require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user, role: :normal) }

  describe '#discount_percent' do
    context 'normal user' do
      it { expect(user.discount_percent).to eq 0 }
    end

    context 'other users' do
      it 'returns 10 percent discount' do
        User.roles.each_key do |role|
          next if role == 'normal'

          user.update(role: role)
          expect(user.discount_percent).to eq 10
        end
      end
    end
  end
end
