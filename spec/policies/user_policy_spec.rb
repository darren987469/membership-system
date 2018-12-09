require 'rails_helper'

describe UserPolicy do
  subject { described_class.new(user, nil) }

  context 'when normal user' do
    let(:user) { create(:user, role: :normal) }

    it { should permit(:upgrade_to_premium) }
  end

  context 'when premium user' do
    let(:user) { create(:user, role: :premium) }

    it { should_not permit(:upgrade_to_premium) }
  end

  context 'when admin user' do
    let(:user) { create(:user, role: :admin) }

    it { should_not permit(:upgrade_to_premium) }
  end

  context 'when owner user' do
    let(:user) { create(:user, role: :owner) }

    it { should_not permit(:upgrade_to_premium) }
  end
end
