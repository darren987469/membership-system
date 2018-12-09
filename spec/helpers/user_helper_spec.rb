require 'rails_helper'

describe UserHelper do
  include described_class

  describe '#upgrade_to_premium_button' do
    context 'normal user' do
      let(:current_user) { create(:user, role: :normal) }

      it 'returns button to upgrade' do
        button_text = 'Upgrade to premium'
        action_path = '/users/upgrade_to_premium'
        http_method = 'patch'
        expect(upgrade_to_premium_button).to include(button_text, action_path, http_method)
      end
    end

    context 'not normal user' do
      let(:current_user) { create(:user, role: :premium) }

      it { expect(upgrade_to_premium_button).to be_nil }
    end
  end
end
