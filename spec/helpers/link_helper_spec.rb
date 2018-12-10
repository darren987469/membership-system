require 'rails_helper'

describe LinkHelper, type: :helper do
  include described_class

  let(:current_user) { create(:user, role: :owner) }

  describe '#link_to_admin' do
    subject { link_to_admin }

    context 'already in admin pages' do
      before { expect(self).to receive(:controller) { Admin::ProductsController.new } }
      it { is_expected.to be_nil }
    end

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

  describe '#link_to_website' do
    subject { link_to_website }

    context 'already in /products page' do
      before { expect(self).to receive(:controller) { ProductsController.new } }
      it { is_expected.to be_nil }
    end

    context 'not in /products page' do
      it { is_expected.to include('Go to Website', 'href="/products"') }
    end
  end

  describe '#link_to_admin_or_website' do
    subject { link_to_admin_or_website }

    context 'in admin pages' do
      before { expect(self).to receive(:controller).twice { Admin::UsersController.new } }

      it { is_expected.to include('Go to Website', 'href="/products"') }
    end

    context 'not in admin page' do
      before { expect(self).to receive(:controller).twice { ProductsController.new } }

      it { is_expected.to include('Go to Admin', 'href="/admin/products"') }
    end
  end
end
