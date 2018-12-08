require 'rails_helper'

describe Admin::ProductPolicy do
  subject { described_class.new(user, nil) }

  context 'when normal user' do
    let(:user) { create(:user, role: :normal) }

    it { should_not permit(:index) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:update) }
    it { should_not permit(:edit) }
    it { should_not permit(:destroy) }
  end

  context 'when premium user' do
    let(:user) { create(:user, role: :premium) }

    it { should_not permit(:index) }
    it { should_not permit(:show) }
    it { should_not permit(:create) }
    it { should_not permit(:new) }
    it { should_not permit(:update) }
    it { should_not permit(:edit) }
    it { should_not permit(:destroy) }
  end

  context 'when admin user' do
    let(:user) { create(:user, role: :admin) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should_not permit(:destroy) }
  end

  context 'when owner user' do
    let(:user) { create(:user, role: :owner) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should_not permit(:destroy) }
  end
end
