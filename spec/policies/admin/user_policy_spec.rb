require 'rails_helper'

describe Admin::UserPolicy do
  subject { described_class.new(user, nil) }

  context 'when normal user' do
    let(:user) { create(:user, role: :normal) }

    it { should_not permit(:index) }
    it { should_not permit(:promote_admin) }
  end

  context 'when premium user' do
    let(:user) { create(:user, role: :premium) }

    it { should_not permit(:index) }
    it { should_not permit(:promote_admin) }
  end

  context 'when admin user' do
    let(:user) { create(:user, role: :admin) }

    it { should permit(:index) }
    it { should_not permit(:promote_admin) }
  end

  context 'when owner user' do
    let(:user) { create(:user, role: :owner) }

    it { should permit(:index) }
    it { should permit(:promote_admin) }
  end
end
