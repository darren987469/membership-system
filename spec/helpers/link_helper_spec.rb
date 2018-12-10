require 'rails_helper'

describe LinkHelper do
  include described_class

  describe '#link_to_admin' do
    subject { link_to_admin }

    context 'admin user' do
      let(:current_user) { create(:user, role: :admin) }
      it { is_expected.to include('Go to Admin', 'href="/admin/products"') }
    end

    context 'owner user' do
      let(:current_user) { create(:user, role: :owner) }
      it { is_expected.to include('Go to Admin', 'href="/admin/products"') }
    end

    context 'normal user' do
      let(:current_user) { create(:user, role: :normal) }
      it { is_expected.to be_nil }
    end

    context 'premium user' do
      let(:current_user) { create(:user, role: :normal) }
      it { is_expected.to be_nil }
    end
  end
end
